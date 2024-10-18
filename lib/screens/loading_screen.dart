import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/users_screen.dart';

import 'package:chat_app/services/auth_service.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    final authenticated = await authService.isLoggedIn();

    print('hello?');
    if (authenticated) {
      // TODO: Conectar al socket server
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const UsersScreen(),
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    } else {
      print('hello login');
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LoginScreen(),
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    }
  }
}
