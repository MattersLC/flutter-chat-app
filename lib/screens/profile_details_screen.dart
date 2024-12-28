import 'package:chat_app/models/loggedin_user.dart';
import 'package:chat_app/widgets/settings/profile/user_details_container.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/services/auth_service.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    LoggedinUser user = authService.user!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondaryHeaderColor,
        elevation: 1,
        centerTitle: false,
        title: Text('Profile', style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: theme.secondaryHeaderColor,
            child: user.profilePicture == '' ?
            Text(
              user.name.substring(0, 2),
              style: TextStyle(color: theme.highlightColor, fontSize: 30),
            ) : Text(user.profilePicture.substring(0, 2)),
          ),
          TextButton(
            onPressed: (){},
            style: ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20))
            ),
            child: Text('Select New Photo', style: TextStyle(color: theme.highlightColor),)
          ),
          UserDetailsContainer(
            header: 'Name',
            content: authService.user!.name,
          ),
          UserDetailsContainer(
            header: 'Last name',
            content: authService.user!.lastName,
          ),
          UserDetailsContainer(
            header: 'Username',
            content: '@${authService.user!.userName}',
          ),
          UserDetailsContainer(
            header: 'About',
            content: authService.user!.about,
          ),
        ],
      ),
    );
  }
}