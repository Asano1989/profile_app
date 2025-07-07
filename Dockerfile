FROM ruby:3.2.2
ARG RUBYGEMS_VERSION=3.3.20

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

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

# entrypoint.sh を作業ディレクトリにコピー
COPY entrypoint.sh /usr/bin/entrypoint.sh

# 実行権限を付与
RUN chmod +x /usr/bin/entrypoint.sh

# コンテナ起動時に entrypoint.sh を実行
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

RUN yarn build

# Tailwindなどをプリコンパイル
RUN bundle exec rails assets:precompile

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]