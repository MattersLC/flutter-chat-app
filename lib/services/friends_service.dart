import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/services/auth_service.dart';

import 'package:chat_app/global/environment.dart';

import 'package:chat_app/models/friend_requests_response.dart';
import 'package:chat_app/models/friends_response.dart';
import 'package:chat_app/models/sent_friend_requests_response.dart';
import 'package:chat_app/models/friend.dart';

class FriendsService with ChangeNotifier {
  List<Friend> _friends = [];
  List<Friend> _friendRequests = []; 
  List<Friend> _sentFriendRequests = [];
  List<Friend> get friends => _friends;
  List<Friend> get friendRequests => _friendRequests;
  List<Friend> get sentFriendRequests => _sentFriendRequests;

  Future<List<Friend>> getFriends() async {
    try {
      final res = await http.get(
        Uri.parse('${Environment.apiUrl}/friends'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        }
      );

      //print(res.body);
      final friendsResponse = friendsResponseFromJson(res.body);
      _friends = friendsResponse.friends;
      notifyListeners();
      return friendsResponse.friends;
    } catch (error) {
      return [];
    }
  }

  Future<List<Friend>> getFriendRequests() async {
    try {
      final res = await http.get(
        Uri.parse('${Environment.apiUrl}/friends/friend-requests'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        }
      );

      final friendsResponse = friendsResponseFromJson(res.body);
      _friendRequests = friendsResponse.friends;
      notifyListeners();

      return friendsResponse.friends;
    } catch (error) {
      return [];
    }
  }

  Future<List<Friend>> getSentFriendRequests() async {
    try {
      final res = await http.get(
        Uri.parse('${Environment.apiUrl}/friends/sent-friend-requests'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        }
      );

      final friendsResponse = friendsResponseFromJson(res.body);
      _sentFriendRequests = friendsResponse.friends;
      notifyListeners();

      return friendsResponse.friends;
    } catch (error) {
      return [];
    }
  }

  Future<int> getTotalFriendRequests() async {
    try {
      final res = await http.get(
        Uri.parse('${Environment.apiUrl}/friends/total-friend-requests'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
      );

      //print(res.body);
      final data = friendRequestsResponseFromJson(res.body);

      return data.totalFriendRequests;
    } catch (error) {
      return 0;
    }
  }

  Future<int> getTotalSentFriendRequests() async {
    try {
      final res = await http.get(
        Uri.parse('${Environment.apiUrl}/friends/total-sent-friend-requests'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
      );

      //print(res.body);
      final data = sentFriendRequestsResponseFromJson(res.body);

      return data.totalSentFriendRequests;
    } catch (error) {
      return 0;
    }
  }

  Future<bool> sendFriendRequest(String toUserId) async {
    final token = await AuthService.getToken();
    final response = await http.post(
      Uri.parse('${Environment.apiUrl}/friends/send-friend-request'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      },
      body: jsonEncode({ "toUserId": toUserId }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> respondFriendRequest(String toUserId, bool isAccepted) async {
    try {
      final res = await http.post(
        Uri.parse('${Environment.apiUrl}/friends/respond-friend-request'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
        body: jsonEncode({
          "toUserId": toUserId,
          "isAccepted": isAccepted
        }),
      );

      if (res.statusCode == 200) {
        if (isAccepted) {
          await getFriends();
        }
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