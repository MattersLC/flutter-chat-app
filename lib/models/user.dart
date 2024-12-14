class User {
  String name;
  String lastName;
  String email;
  String about;
  bool online;
  dynamic lastConnection;
  String profilePicture;
  List<dynamic> pinnedChats;
  List<dynamic> friends;
  List<dynamic> blocked;
  String userName;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> friendRequests;
  String uid;

  User({
    required this.name,
    required this.lastName,
    required this.email,
    required this.about,
    required this.online,
    required this.lastConnection,
    required this.profilePicture,
    required this.pinnedChats,
    required this.friends,
    required this.blocked,
    required this.userName,
    required this.createdAt,
    required this.updatedAt,
    required this.friendRequests,
    required this.uid,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    lastName: json["lastName"],
    email: json["email"],
    about: json["about"],
    online: json["online"],
    lastConnection: json["lastConnection"],
    profilePicture: json["profilePicture"],
    pinnedChats: List<dynamic>.from(json["pinnedChats"].map((x) => x)),
    friends: List<dynamic>.from(json["friends"].map((x) => x)),
    blocked: List<dynamic>.from(json["blocked"].map((x) => x)),
    userName: json["userName"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    friendRequests:
        List<dynamic>.from(json["friendRequests"].map((x) => x)),
    uid: json["uid"],
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
    "friends": List<dynamic>.from(friends.map((x) => x)),
    "blocked": List<dynamic>.from(blocked.map((x) => x)),
    "userName": userName,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "friendRequests": List<dynamic>.from(friendRequests.map((x) => x)),
    "uid": uid,
  };
}
