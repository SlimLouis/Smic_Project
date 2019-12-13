class User {
  final String email;
  final String password;

  User(this.email, this.password);

  Map toJson() => {
        'email': email,
        'password': password,
      };

  User.fromJson(Map json)
      : password = json['password'],
        email = json['email'];
}
