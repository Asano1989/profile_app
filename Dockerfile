FROM ruby:3.2.2
ARG RUBYGEMS_VERSION=3.3.20

# 作業ディレクトリを指定
WORKDIR /profile_app

# ホストのGemfileをコンテナ内の作業ディレクトリにコピー
COPY Gemfile Gemfile.lock /profile_app/

# bundle installを実行
RUN bundle install

# watchmanのインストール（2025/06/27追記）
RUN apt-get update -qq && apt-get install -y watchman

# ホストのファイルをコンテナ内の作業ディレクトリにコピー
COPY . /profile_app/

# entrypoint.shをコンテナ内の作業ディレクトリにコピー
COPY entrypoint.sh /usr/bin/

# entrypoint.shの実行権限を付与
RUN chmod +x /usr/bin/entrypoint.sh

# コンテナ起動時にentrypoint.shを実行するように設定
ENTRYPOINT ["entrypoint.sh"]

# コンテナ起動時に実行するコマンドを指定
CMD ["rails", "server", "-b", "0.0.0.0"]