class Chat {
  String uid;
  String name;
  bool online;
  String lastMessage;
  DateTime lastMessageTime;
  bool lastMessageViewed;
  String profilePicture;
  final bool isPinned;

  Chat({
    required this.uid,
    required this.name,
    required this.online,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastMessageViewed,
    required this.profilePicture,
    required this.isPinned,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    uid: json["_id"],
    name: json["name"],
    online: json["online"],
    lastMessage: json["lastMessage"],
    lastMessageTime: DateTime.parse(json["lastMessageTime"]).toLocal(),
    lastMessageViewed: json["lastMessageViewed"],
    profilePicture: json["profilePicture"],
    isPinned: json["isPinned"],
  );

  Map<String, dynamic> toJson() => {
      "uid": uid,
      "name": name,
      "online": online,
      "lastMessage": lastMessage,
      "lastMessageTime": lastMessageTime.toLocal(),
      "lastMessageViewed": lastMessageViewed,
      "profilePicture": profilePicture,
      "isPinned": isPinned,
    };
}
