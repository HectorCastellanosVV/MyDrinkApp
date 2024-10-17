import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? username;
  @HiveField(2)
  String? password;
  @HiveField(3)
  String? token;
  User({this.name, this.username, this.password, this.token});

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'],
        username: json['username'],
        password: json['password'],
        token: json['token'],
      );
}
