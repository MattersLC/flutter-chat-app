import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/global/environment.dart';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/models/profile_response.dart';

class ProfileService extends ChangeNotifier {
  Future<bool> changePhoto(File newPhoto) async {
    /*try {
      // define the path in storage
      String filePath = 'uploaded_images/${DateTime.now()}.png';
    }*/











    try {
      final res = await http.post(
        Uri.parse('${Environment.apiUrl}/profile/change-name'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
        body: jsonEncode({
          "newPhoto": newPhoto,
        }),
      );

      final response = profileResponseFromJson(res.body);

      //authService.user!.profilePicture = newPhoto.path;
      //authService.notifyListeners();

      if (response.ok) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  /*Future<bool> changeName(String newName, AuthService authService) async {
    try {
      final res = await http.post(
        Uri.parse('${Environment.apiUrl}/profile/change-name'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
        body: jsonEncode({
          "newName": newName,
        }),
      );

      final response = profileResponseFromJson(res.body);

      authService.user!.name = newName;
      authService.notifyListeners();

      if (response.ok) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }*/

  
}
