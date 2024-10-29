import 'package:chat_app/models/chats_response.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/global/environment.dart';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/models/chat.dart';
//import 'package:chat_app/models/users_response.dart';

class ChatsService {
  Future<List<Chat>> getChats() async {
    try {
      final res = await http.get(
        Uri.parse('${Environment.apiUrl}/chats'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
      );

      final chatsResponse = chatsResponseFromJson(res.body);

      return chatsResponse.chats;
    } catch (error) {
      return [];
    }
  }
}
