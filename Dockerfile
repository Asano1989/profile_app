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
  watchman

# Node.js & Yarn のインストール
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs \
  && npm install -g yarn

RUN yarn add jquery @popperjs/core
RUN yarn add @hotwired/stimulus

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
COPY entrypoint.sh /usr/bin/

# entrypoint.shの実行権限を付与
RUN chmod +x /usr/bin/entrypoint.sh

# コンテナ起動時にentrypoint.shを実行するように設定
ENTRYPOINT ["entrypoint.sh"]

# コンテナ起動時に実行するコマンドを指定
CMD ["rails", "server", "-b", "0.0.0.0"]