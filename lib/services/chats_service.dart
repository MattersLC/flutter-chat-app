import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/global/environment.dart';

import 'package:chat_app/services/auth_service.dart';

import 'package:chat_app/models/chat.dart';
import 'package:chat_app/models/chats_response.dart';
//import 'package:chat_app/models/users_response.dart';

class ChatsService with ChangeNotifier {
  Future<List<Chat>> getChats() async {
    try {
      final res = await http.get(
        Uri.parse('${Environment.apiUrl}/chats'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
      );

      //print(res.body);
      final chatsResponse = chatsResponseFromJson(res.body);
      //print('so?');
      //print(chatsResponse);
      return chatsResponse.chats;
    } catch (error) {
      return [];
    }
  }

  Future<String> pinChat(String toUserId) async {
    try {
      final res = await http.post(
        Uri.parse('${Environment.apiUrl}/pin-chat'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
        body: jsonEncode({
          "toUserId": toUserId
        }),
      );

      print(res.body);
      if (res.statusCode == 200) {
        return '';
      } else {
        return 'Unexpected error: ${res.statusCode}';
      }
    } on SocketException {
      return 'Connection was refused';
    } on HttpException {
      return 'There\'s an error while connecting with the server';
    } catch (error) {
      return 'Unexpected error: $error';
    }
  }

  Future<String> deleteChat(String toUserId) async {
    try {
      final res = await http.post(
        Uri.parse('${Environment.apiUrl}/delete-chat'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
        body: jsonEncode({
          "toUserId": toUserId
        }),
      );

      print(res.body);
      if (res.statusCode == 200) {
        return '';
      } else {
        return 'Unexpected error: ${res.statusCode}';
      }
    } on SocketException {
      return 'Connection was refused';
    } on HttpException {
      return 'There\'s an error while connecting with the server';
    } catch (error) {
      return 'Unexpected error: $error';
    }
  }
}
