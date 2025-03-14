import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {
  bool ok;
  String msg;

  ProfileResponse({
    required this.ok,
    required this.msg,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
    ok: json["ok"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "msg": msg,
  };
}
