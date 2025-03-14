import 'dart:convert';
import 'dart:io';

import 'package:chat_app/models/profile_response.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_app/models/loggedin_user.dart';
import 'package:chat_app/models/login_response.dart';

import 'package:chat_app/global/environment.dart';

class AuthService with ChangeNotifier {
  LoggedinUser? _user;
  LoggedinUser? get user => _user;
  bool _authenticating = false;

  // firebase storage
  final firebaseStorage = FirebaseStorage.instance;

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

  Future<String> login(String email, String password) async {
    authenticating = true;
    final data = {
      'email': email,
      'password': password,
    };

    try {
      final res = await http.post(
        Uri.parse('${Environment.apiUrl}/login'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      authenticating = false;

      final loginResponse = loginResponseFromJson(res.body);
      _user = loginResponse.user;

      if (loginResponse.token != '') {
        await _saveToken(loginResponse.token);
      }

      return loginResponse.message;
    } on SocketException {
      authenticating = false;
      return 'Connection was refused';
    } on HttpException {
      authenticating = false;
      return 'There\'s an error while connecting with the server';
    } catch (error) {
      authenticating = false;
      return 'Unexpected error: $error';
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
      _user = loginResponse.user;
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

    try {
      final res = await http.get(
        Uri.parse('${Environment.apiUrl}/login/renew'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': token,
        },
      );

      if (res.statusCode == 200) {
        final loginResponse = loginResponseFromJson(res.body);
        _user = loginResponse.user;
        await _saveToken(loginResponse.token);

        return true;
      } else {
        _logOut();
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _logOut() async {
    await _storage.delete(key: 'token');
  }

  Future<ProfileResponse> changePhoto(File newPhoto) async {
    try {
      // define the path in storage
      String filePath = 'uploaded_images/${_user!.uid}-${DateTime.now()}.png';
      print("filePath: $filePath");

      // verify if the user already had a profile photo
      /*if (_user!.profilePicture != '') {
        // get path name and delete from firebase
        final String path = extractPathFromUrl(_user!.profilePicture); 
        await firebaseStorage.ref(path).delete();
      }*/

      // Upload new file
      TaskSnapshot uploadTask = await FirebaseStorage.instance.ref(filePath).putFile(newPhoto);
      if (uploadTask.state != TaskState.success) {
        throw Exception("File upload failed");
      }

      // after uploading, fetch the download URL
      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();
      print("downloadUrl: $downloadUrl");

      // update the downloadUrl on the database
      final res = await http.post(
        Uri.parse('${Environment.apiUrl}/profile/change-photo'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
        body: jsonEncode({
          "newPhoto": downloadUrl,
        }),
      );

      print(res.body);

      // process the response
      final response = profileResponseFromJson(res.body);

      // update the local variables if success
      if (response.ok) {
        _user!.profilePicture = downloadUrl;
        notifyListeners();
      }

      // return the response
      return response;
    } catch (e) {
      print("Error uploading the image: $e");
      return ProfileResponse(ok: false, msg: e.toString());
    }
  }

  String extractPathFromUrl(String url) {
    Uri uri = Uri.parse(url);

    // extracting the part of the url we need
    String encodedPath = uri.pathSegments.last;

    // url decoding the path
    return Uri.decodeComponent(encodedPath);
  }

  Future<bool> changeName(String newName) async {
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

      if (response.ok) {
        _user!.name = newName;
        notifyListeners();

        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> changeLastName(String newLastName) async {
    try {
      final res = await http.post(
        Uri.parse('${Environment.apiUrl}/profile/change-lastname'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
        body: jsonEncode({
          "newLastName": newLastName,
        }),
      );

      final response = profileResponseFromJson(res.body);

      _user!.name = newLastName;
      notifyListeners();

      if (response.ok) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> changeUserName(String newUserName) async {
    try {
      final res = await http.post(
        Uri.parse('${Environment.apiUrl}/profile/change-username'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
        body: jsonEncode({
          "newUserName": newUserName,
        }),
      );

      final response = profileResponseFromJson(res.body);

      _user!.name = newUserName;
      notifyListeners();

      if (response.ok) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> changeAbout(String newDescription) async {
    try {
      final res = await http.post(
        Uri.parse('${Environment.apiUrl}/profile/change-about'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
        body: jsonEncode({
          "newDescription": newDescription,
        }),
      );

      final response = profileResponseFromJson(res.body);

      _user!.about = newDescription;
      notifyListeners();

      if (response.ok) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
