FROM ruby:3.2.2
ARG RUBYGEMS_VERSION=3.3.20

# 作業ディレクトリを指定
WORKDIR /profile_app

# 必要なライブラリのインストール（watchmanなど）
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  curl \
  git \
  watchman \
  && rm -rf /var/lib/apt/lists/* # aptキャッシュをクリア

# Node.js & Yarn & PostgreSQL clientのインストール
# NodeSourceのセットアップスクリプトをより確実に実行し、Yarnのインストールを明示的に行う
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get update -qq \
  && apt-get install -y nodejs postgresql-client \
  && npm install -g yarn \
  && npm cache clean --force \
  && rm -rf /var/lib/apt/lists/*

# package.jsonとyarn.lockを先にコピーしてキャッシュを効かせる
COPY package.json yarn.lock ./
RUN yarn install

# GemfileとGemfile.lockを先にコピーしてbundle install
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーション全体をコピー
COPY . .

# esbuild 出力先ディレクトリを作成（エラー回避）
RUN mkdir -p app/assets/builds

# entrypoint.shをコンテナ内の作業ディレクトリにコピー
# COPY entrypoint.sh /usr/bin/

# entrypoint.shの実行権限を付与
# RUN chmod +x /usr/bin/entrypoint.sh

# コンテナ起動時にentrypoint.shを実行するように設定
# ENTRYPOINT ["entrypoint.sh"]

# Tailwindなどをプリコンパイル
RUN bin/rails assets:precompile

# コンテナ起動時に実行するコマンドを指定
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]