import 'package:chat_app/models/user.dart';

class Chat {
  User user;
  String lastMessage;
  DateTime lastMessageTime;
  bool lastMessageViewed;

  Chat({
    required this.user,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastMessageViewed,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        user: User.fromJson(json["user"]),
        lastMessage: json["lastMessage"],
        lastMessageTime: DateTime.parse(json["lastMessageTime"]),
        lastMessageViewed: json["lastMessageViewed"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "lastMessage": lastMessage,
        "lastMessageTime": lastMessageTime.toIso8601String(),
        "lastMessageViewed": lastMessageViewed,
      };
}
