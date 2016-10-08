# pomodoro-life

「pomodoro-life」はポモドーロ法でタスクを管理するアプリケーションです。

# 動作環境

- Ruby 2.3.1
- Ruby on Rails 5.0.0.1
- MySQL 5.6

# 開発環境動作手順

## レポジトリのクローン

```
$ git clone git@github.com:kuboshizuma/pomodoro-life.git
```

## Gemライブラリのインストール

```
bundle install
```

## DB環境の準備

```
cp dot.env .env
```

以下のように`.env`にデータベースのusername、passwordを記入。(適宜)

```
DATABASE_NAME_DEVELOPMENT=root
DATABASE_PASSWORD_DEVELOPMENT=root
```

## Facebook APIの準備

`.env`内にFacebookの`APP_Id`と`SECRET_ID`を設定。
下記はサンプルなので値は別途確認。

```
FACEBOOK_APP_ID_DEV=1234567890
FACEBOOK_APP_SECRET_DEV=abcdefghijklmnopqrstuvwxyz
```

## ドメインの設定

`/etc/hosts`に以下のように記述する。
(`localhost`の代わりに`dev.pomodoro-life.com`が使えるようになる)

```
127.0.0.1 dev.pomodoro-life.com
```

## データベースの作成・準備

```
bundle exec rake db:create
bundle exec rake db:migrate
```

## Ruby on Rails の起動

```
bundle exec rails s
```

`http://dev.pomodoro-life.com:3000`にアクセスする。
