import 'dart:convert';

FriendRequestsResponse friendRequestsResponseFromJson(String str) => FriendRequestsResponse.fromJson(json.decode(str));

String friendRequestsResponseToJson(FriendRequestsResponse data) => json.encode(data.toJson());

class FriendRequestsResponse {
  bool ok;
  int friendRequests;
  int desde;

  FriendRequestsResponse({
    required this.ok,
    required this.friendRequests,
    required this.desde,
  });

  factory FriendRequestsResponse.fromJson(Map<String, dynamic> json) => FriendRequestsResponse(
    ok: json["ok"],
    friendRequests: json["friendRequests"],
    desde: json["desde"],
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "friendRequests": friendRequests,
    "desde": desde,
  };
}
