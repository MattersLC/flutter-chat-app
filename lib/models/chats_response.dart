import 'dart:convert';
import 'package:chat_app/models/chat.dart';

ChatsResponse chatsResponseFromJson(String str) =>
    ChatsResponse.fromJson(json.decode(str));
String chatsResponseToJson(ChatsResponse data) => json.encode(data.toJson());

class ChatsResponse {
  bool ok;
  List<Chat> chats;
  List<Chat> pinnedChats;
  int desde;

  ChatsResponse({
    required this.ok,
    required this.chats,
    required this.pinnedChats,
    required this.desde,
  });

  factory ChatsResponse.fromJson(Map<String, dynamic> json) => ChatsResponse(
    ok: json["ok"],
    chats: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
    pinnedChats: List<Chat>.from(json["pinnedChats"].map((x) => Chat.fromJson(x))),
    desde: json["desde"],
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "chats": List<dynamic>.from(chats.map((x) => x.toJson())),
    "pinnedChats": List<dynamic>.from(chats.map((x) => x.toJson())),
    "desde": desde,
  };
}
