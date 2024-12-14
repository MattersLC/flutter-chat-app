class Friend {
  final String uid;
  final String name;
  final String email;
  final bool online;
  final dynamic lastConnection;

  Friend({
    required this.uid,
    required this.name,
    required this.email,
    required this.online,
    required this.lastConnection,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
    uid: json["uid"],
    name: json["name"],
    email: json["email"],
    online: json["online"],
    lastConnection: json["lastConnection"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "name": name,
    "email": email,
    "online": online,
    "lastConnection": lastConnection,
  };
}