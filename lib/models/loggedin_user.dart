class LoggedinUser {
  String name;
  String lastName;
  String email;
  String about;
  bool online;
  dynamic lastConnection;
  String profilePicture;
  List<dynamic> pinnedChats;
  String userName;
  DateTime createdAt;
  DateTime updatedAt;
  String uid;
  String relationshipStatus;

  LoggedinUser({
    required this.name,
    required this.lastName,
    required this.email,
    required this.about,
    required this.online,
    required this.lastConnection,
    required this.profilePicture,
    required this.pinnedChats,
    required this.userName,
    required this.createdAt,
    required this.updatedAt,
    required this.uid,
    required this.relationshipStatus,
  });

  factory LoggedinUser.fromJson(Map<String, dynamic> json) => LoggedinUser(
    name: json["name"],
    lastName: json["lastName"],
    email: json["email"],
    about: json["about"],
    online: json["online"],
    lastConnection: json["lastConnection"],
    profilePicture: json["profilePicture"],
    pinnedChats: List<dynamic>.from(json["pinnedChats"].map((x) => x)),
    userName: json["userName"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    uid: json["uid"],
    relationshipStatus: json["relationshipStatus"] ?? 'none',
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "lastName": lastName,
    "email": email,
    "about": about,
    "online": online,
    "lastConnection": lastConnection,
    "profilePicture": profilePicture,
    "pinnedChats": List<dynamic>.from(pinnedChats.map((x) => x)),
    "userName": userName,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "uid": uid,
    "relationshipStatus": relationshipStatus,
  };
}
