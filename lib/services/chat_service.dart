import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/global/environment.dart';

import 'package:chat_app/services/auth_service.dart';

import 'package:chat_app/models/user.dart';
import 'package:chat_app/models/message_response.dart';

class ChatService with ChangeNotifier {
  //late User userDestination;
  late String uid;
  late String name;
  late bool online;

  Future<List<Message>> getChat(String userID) async {
    final res = await http
        .get(Uri.parse('${Environment.apiUrl}/messages/$userID'), headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken(),
    });

    final messagesRes = messageResponseFromJson(res.body);

    return messagesRes.messages;
  }
}
