import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/global/environment.dart';

import 'package:chat_app/services/auth_service.dart';

import 'package:chat_app/models/chat.dart';
import 'package:chat_app/models/chats_response.dart';

class ChatsService with ChangeNotifier {
  List<Chat> _chats = [];
  List<Chat> _pinnedChats = [];
  List<Chat> get chats => _chats;
  List<Chat> get pinnedChats => _pinnedChats;

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
      _chats = chatsResponse.chats;
      _pinnedChats = chatsResponse.pinnedChats;
      notifyListeners();

      return chatsResponse.chats;
    } catch (error) {
      return [];
    }
  }

  Future<String> pinChat(Chat toUser) async {
    try {
      final res = await http.post(
        Uri.parse('${Environment.apiUrl}/chats/pin-chat'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
        body: jsonEncode({
          "toUserId": toUser.uid
        }),
      );

      print(res.body);
      if (res.statusCode == 200) {
        _chats.removeWhere((chat) => chat == toUser);
        _pinnedChats.add(toUser);
        notifyListeners();
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

  Future<String> unpinChat(Chat toUser) async {
    try {
      final res = await http.post(
        Uri.parse('${Environment.apiUrl}/chats/unpin-chat'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
        body: jsonEncode({
          "toUserId": toUser.uid
        }),
      );

      print(res.body);
      if (res.statusCode == 200) {
        _pinnedChats.removeWhere((chat) => chat == toUser);
        _chats.add(toUser);
        notifyListeners();
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
