class User {
  final String uid;
  final String name;
  final String lastName;
  final String email;
  final String about;
  final String profilePicture;
  String relationshipStatus;
  final bool online;
  final dynamic lastConnection;

  User({
    required this.uid,
    required this.name,
    required this.lastName,
    required this.email,
    required this.about,
    required this.profilePicture,
    required this.relationshipStatus,
    required this.online,
    required this.lastConnection,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    uid: json["uid"],
    name: json["name"],
    lastName: json["lastName"],
    email: json["email"],
    about: json["about"],
    profilePicture: json["profilePicture"],
    relationshipStatus: json["relationshipStatus"],
    online: json["online"],
    lastConnection: json["lastConnection"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "name": name,
    "lastName": lastName,
    "email": email,
    "about": about,
    "profilePicture": profilePicture,
    "relationshipStatus": relationshipStatus,
    "online": online,
    "lastConnection": lastConnection,
  };
}