import 'package:chat_app/models/user.dart';

class Chat {
  User user;
  //String id;
  //String name;
  String lastMessage;
  DateTime lastMessageTime;
  bool lastMessageViewed;
  final bool isPinned;

  Chat({
    required this.user,
    //required this.id,
    //required this.name,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastMessageViewed,
    required this.isPinned,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    user: User.fromJson(json["user"]),
    //id: json["_id"],
    //name: json["name"],
    lastMessage: json["lastMessage"],
    lastMessageTime: DateTime.parse(json["lastMessageTime"]),
    lastMessageViewed: json["lastMessageViewed"],
    isPinned: json["isPinned"],
  );

  Map<String, dynamic> toJson() => {
      "user": user.toJson(),
      //"_id": id,
      //"name": name,
      "lastMessage": lastMessage,
      "lastMessageTime": lastMessageTime.toIso8601String(),
      "lastMessageViewed": lastMessageViewed,
      "isPinned": isPinned,
    };
}
