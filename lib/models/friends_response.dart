import 'dart:convert';
import 'package:chat_app/models/friend.dart';

FriendsResponse friendsResponseFromJson(String str) =>
    FriendsResponse.fromJson(json.decode(str));
String friendsResponseToJson(FriendsResponse data) => json.encode(data.toJson());

class FriendsResponse {
  bool ok;
  List<Friend> friends;
  int desde;

  FriendsResponse({
    required this.ok,
    required this.friends,
    required this.desde,
  });

  factory FriendsResponse.fromJson(Map<String, dynamic> json) => FriendsResponse(
    ok: json["ok"],
    friends: List<Friend>.from(json["friends"].map((x) => Friend.fromJson(x))),
    desde: json["desde"],
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "friends": List<dynamic>.from(friends.map((x) => x.toJson())),
    "desde": desde,
  };
}