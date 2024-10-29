import 'dart:convert';

import 'package:chat_app/models/user.dart';

UsersResponse usersResponseFromJson(String str) =>
    UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

class UsersResponse {
  bool ok;
  List<User> users;
  int desde;

  UsersResponse({
    required this.ok,
    required this.users,
    required this.desde,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        ok: json["ok"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        desde: json["desde"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "desde": desde,
      };
}
