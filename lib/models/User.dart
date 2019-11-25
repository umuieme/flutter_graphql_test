class User {
  final String fullname;
  final String username;
  final String password;

  User({this.fullname, this.username, this.password});

  static User fromJson(Map<String, dynamic> json) {
    return User(
        fullname: json['fullname'],
        username: json['username'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}
