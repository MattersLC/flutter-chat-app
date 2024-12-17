import 'dart:convert';

FriendRequestsResponse friendRequestsResponseFromJson(String str) => FriendRequestsResponse.fromJson(json.decode(str));

String friendRequestsResponseToJson(FriendRequestsResponse data) => json.encode(data.toJson());

class FriendRequestsResponse {
  bool ok;
  int totalFriendRequests;
  int desde;

  FriendRequestsResponse({
    required this.ok,
    required this.totalFriendRequests,
    required this.desde,
  });

  factory FriendRequestsResponse.fromJson(Map<String, dynamic> json) => FriendRequestsResponse(
    ok: json["ok"],
    totalFriendRequests: json["totalFriendRequests"],
    desde: json["desde"],
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "totalFriendRequests": totalFriendRequests,
    "desde": desde,
  };
}
