import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_app/models/user.dart';
import 'package:chat_app/models/login_response.dart';

import 'package:chat_app/global/environment.dart';

class AuthService with ChangeNotifier {
  User? user;
  bool _authenticating = false;

  final _storage = new FlutterSecureStorage();

  bool get authenticating => _authenticating;
  set authenticating(bool value) {
    _authenticating = value;
    notifyListeners();
  }

  // Getters estáticos del token
  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token!;
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    authenticating = true;
    final data = {
      'email': email,
      'password': password,
    };

    final res = await http.post(
      Uri.parse('${Environment.apiUrl}/login'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    authenticating = false;

    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      user = loginResponse.user;

      await _saveToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(
      String name, String lastName, String email, String password) async {
    authenticating = true;

    final data = {
      'name': name,
      'lastName': lastName,
      'email': email,
      'password': password,
    };

    final res = await http.post(
      Uri.parse('${Environment.apiUrl}/login/new'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    authenticating = false;

    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      user = loginResponse.user;
      await _saveToken(loginResponse.token);

      return true;
    } else {
      final resBody = jsonDecode(res.body);
      return resBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    if (token == null) {
      _logOut();
      return false;
    }

    final res = await http.get(
      Uri.parse('${Environment.apiUrl}/login/renew'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      },
    );

    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      user = loginResponse.user;
      await _saveToken(loginResponse.token);

      return true;
    } else {
      _logOut();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _logOut() async {
    await _storage.delete(key: 'token');
  }
}
