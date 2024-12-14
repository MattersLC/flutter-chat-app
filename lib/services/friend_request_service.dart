/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/global/environment.dart';
import 'package:chat_app/services/auth_service.dart';

class FriendRequestService with ChangeNotifier {
  Future<bool> sendFriendRequest(String toUserId) async {
    final token = await AuthService.getToken();
    final response = await http.post(
      Uri.parse('${Environment.apiUrl}/friends/send-friend-request'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      },
      body: { "toUserId": toUserId },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}*/
