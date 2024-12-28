import 'dart:convert';

SendFriendRequestResponse sendFriendRequestResponseFromJson(String str) => SendFriendRequestResponse.fromJson(json.decode(str));

String sendFriendRequestResponseToJson(SendFriendRequestResponse data) => json.encode(data.toJson());

class SendFriendRequestResponse {
  bool ok;
  String relationship;
  String msg;

  SendFriendRequestResponse({
    required this.ok,
    required this.relationship,
    required this.msg,
  });

  factory SendFriendRequestResponse.fromJson(Map<String, dynamic> json) => SendFriendRequestResponse(
    ok: json["ok"],
    relationship: json["relationship"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "relationship": relationship,
    "msg": msg,
  };
}

/*class Relationship {
  String fromUserId;
  String toUserId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Relationship({
    required this.fromUserId,
    required this.toUserId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
    fromUserId: json["fromUserId"],
    toUserId: json["toUserId"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "fromUserId": fromUserId,
    "toUserId": toUserId,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}*/
