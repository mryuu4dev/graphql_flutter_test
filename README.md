# graphql_flutter_test

Googleサインインのデモアプリケーションです。Googleアカウントでサインインし、サインイン情報をHasuraで作成したGraphQLサーバーに送信します。

## Usage
1. [この](https://github.com/JasperEssien2/music-mates-backend)Djangoプロジェクトを参考に[Hasura](https://hasura.io/)でテーブル, カラム, サンプルデータを作成する
2. `.env`ファイルをルートディレクトリに作成する
    ```
    HASURA_GRAPHQL_ENDPOINT=<your_hasura_graphql_endpoint>
    HASURA_GRAPHQL_ADMIN_SECRET=<your_hasura_graphql_admin_secret>
    ```
3. [こちら](https://www.youtube.com/watch?v=E5WgU6ERZzA)を参考に[GCP](https://console.cloud.google.com)でGoogleSignIn用のOAuth同意画面, 承認情報を作成する.
4. `key.properties`ファイルをandroidディレクトリ直下に作成する
    ```
    keyAlias=<your_key_alias>
    keyPassword=<your_key_password>
    storeFile=<your_store_file>
    storePassword=<your_store_password>
    ```
