import 'dart:convert';

import 'package:intl/intl.dart';

MessageResponse messageResponseFromJson(String str) =>
    MessageResponse.fromJson(json.decode(str));

String messageResponseToJson(MessageResponse data) =>
    json.encode(data.toJson());

class MessageResponse {
  bool ok;
  List<Message> messages;

  MessageResponse({
    required this.ok,
    required this.messages,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      MessageResponse(
        ok: json["ok"],
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}

class Message {
  String from;
  String to;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  Message({
    required this.from,
    required this.to,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    from: json["from"],
    to: json["to"],
    message: json["message"],
    createdAt: DateTime.parse(json["createdAt"]).toLocal(),
    updatedAt: DateTime.parse(json["updatedAt"]).toLocal(),
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
    "message": message,
    "createdAt": createdAt.toLocal(),
    "updatedAt": updatedAt.toLocal(),
  };
}
