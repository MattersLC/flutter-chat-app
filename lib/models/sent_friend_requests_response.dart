import 'dart:convert';

SentFriendRequestsResponse sentFriendRequestsResponseFromJson(String str) => SentFriendRequestsResponse.fromJson(json.decode(str));

String sentFriendRequestsResponseToJson(SentFriendRequestsResponse data) => json.encode(data.toJson());

class SentFriendRequestsResponse {
  bool ok;
  int sentFriendRequests;
  int desde;

  SentFriendRequestsResponse({
    required this.ok,
    required this.sentFriendRequests,
    required this.desde,
  });

  factory SentFriendRequestsResponse.fromJson(Map<String, dynamic> json) => SentFriendRequestsResponse(
    ok: json["ok"],
    sentFriendRequests: json["sentFriendRequests"],
    desde: json["desde"],
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "sentFriendRequests": sentFriendRequests,
    "desde": desde,
  };
}
