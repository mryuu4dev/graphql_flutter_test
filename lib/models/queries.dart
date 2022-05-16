class MusicMateQueries {
  String createAccount() {
    return """
    mutation createUser(\$object: users_insert_input!) {
      insert_users_one(object: \$object) {
        name
        image_url
        user_artists {
          artist {
            name
            description
            image_url
          }
        }
      }
    }
    """;
  }
}