import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/services/auth_service.dart';

import 'package:chat_app/global/environment.dart';

import 'package:chat_app/models/user.dart';
import 'package:chat_app/models/send_friend_request_response.dart';
import 'package:chat_app/models/users_response.dart';
import 'package:chat_app/models/friend_requests_response.dart';
import 'package:chat_app/models/friends_response.dart';
import 'package:chat_app/models/sent_friend_requests_response.dart';

class UsersService with ChangeNotifier {
  List<User> _users = [];
  List<User> _friends = [];
  List<User> _friendRequests = [];
  List<User> _sentFriendRequests = [];
  int _totalFriendRequests = 0;
  int _totalSentFriendRequests = 0;
  List<User> get users => _users;
  List<User> get friends => _friends;
  List<User> get friendRequests => _friendRequests;
  List<User> get sentFriendRequests => _sentFriendRequests;
  int get totalFriendRequests => _totalFriendRequests;
  int get totalSentFriendRequests => _totalSentFriendRequests;

  Future<List<User>> getUsers() async {
    try {
      final res = await http.get(
        Uri.parse('${Environment.apiUrl}/users'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
      );

      final usersResponse = usersResponseFromJson(res.body);
      _users = usersResponse.users;
      notifyListeners();

      return usersResponse.users;
    } catch (error) {
      return [];
    }
  }

  Future<List<User>> getFriends() async {
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

  Future<List<User>> getFriendRequests() async {
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

  Future<List<User>> getSentFriendRequests() async {
    try {
      final res = await http.get(
        Uri.parse('${Environment.apiUrl}/friends/sent-friend-requests'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        }
      );

      print(res.body);
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

      final data = sentFriendRequestsResponseFromJson(res.body);
      print(data.totalSentFriendRequests);
      _totalSentFriendRequests = data.totalSentFriendRequests;
      notifyListeners();

      return data.totalSentFriendRequests;
    } catch (error) {
      return 0;
    }
  }

  Future<SendFriendRequestResponse> sendFriendRequest(String toUserId) async {
    final res = await http.post(
      Uri.parse('${Environment.apiUrl}/friends/send-friend-request'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken(),
      },
      body: jsonEncode({
        "toUserId": toUserId,
      }),
    );

    final data = sendFriendRequestResponseFromJson(res.body);
    if (data.ok) {
      // Get the current user
      User user = _users.firstWhere((element) => (element.uid == toUserId));

      // Add the user to respective list
      if (data.relationship == 'pending') {
        _sentFriendRequests.add(user);
        _totalSentFriendRequests++;
      } else {
        _friends.add(user);
      }
      // Update the relationship status to 'pending' for the specific user
      _users.firstWhere((user) => user.uid == toUserId).relationshipStatus = 'pending';

      notifyListeners();
    }
    return data;
  }

  Future<bool> unsendFriendRequest(String toUserId) async {
    final res = await http.post(
      Uri.parse('${Environment.apiUrl}/friends/unsend-friend-request'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken(),
      },
      body: jsonEncode({
        "toUserId": toUserId,
      }),
    );

    if (res.statusCode == 200) {
      _sentFriendRequests.removeWhere((user) => (user.uid == toUserId));
      _users.firstWhere((user) => user.uid == toUserId).relationshipStatus = 'none';
      _totalSentFriendRequests--;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteFriend(String toUserId) async {
    final res = await http.post(
      Uri.parse('${Environment.apiUrl}/friends/delete-friend'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken(),
      },
      body: jsonEncode({
        "toUserId": toUserId,
      }),
    );

    if (res.statusCode == 200) {
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