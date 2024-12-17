import 'dart:convert';

SentFriendRequestsResponse sentFriendRequestsResponseFromJson(String str) => SentFriendRequestsResponse.fromJson(json.decode(str));

String sentFriendRequestsResponseToJson(SentFriendRequestsResponse data) => json.encode(data.toJson());

class SentFriendRequestsResponse {
  bool ok;
  int totalSentFriendRequests;
  int desde;

  SentFriendRequestsResponse({
    required this.ok,
    required this.totalSentFriendRequests,
    required this.desde,
  });

  factory SentFriendRequestsResponse.fromJson(Map<String, dynamic> json) => SentFriendRequestsResponse(
    ok: json["ok"],
    totalSentFriendRequests: json["totalSentFriendRequests"],
    desde: json["desde"],
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "totalSentFriendRequests": totalSentFriendRequests,
    "desde": desde,
  };
}
