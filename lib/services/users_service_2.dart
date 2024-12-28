/*import 'package:http/http.dart' as http;

import 'package:chat_app/global/environment.dart';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/models/loggedin_user.dart';
import 'package:chat_app/models/users_response.dart';

class UsersService2 {
  Future<List<LoggedinUser>> getUsers() async {
    try {
      final res = await http.get(
        Uri.parse('${Environment.apiUrl}/users'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
      );

      final usersResponse = usersResponseFromJson(res.body);

      return usersResponse.users;
    } catch (error) {
      return [];
    }
  }
}
*/