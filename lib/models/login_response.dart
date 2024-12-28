import 'dart:convert';

import 'package:chat_app/models/loggedin_user.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool ok;
  LoggedinUser? user;
  String token;
  String message;

  LoginResponse({
    required this.ok,
    required this.user,
    required this.token,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    ok: json["ok"],
    user: json["user"] == null ? null : LoggedinUser.fromJson(json["user"]),
    token: json["token"] ?? '',
    message: json["msg"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "user": user!.toJson(),
    "token": token,
    "msg": message,
  };
}
