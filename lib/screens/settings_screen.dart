import 'package:flutter/material.dart';

import 'package:chat_app/services/theme_service.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';

import 'package:chat_app/widgets/settings/settings_user_label.dart';
import 'package:chat_app/widgets/settings/settings_label.dart';
import 'package:chat_app/widgets/settings/settings_label_switch.dart';

import 'package:chat_app/global/chat_colors.dart';
import 'package:chat_app/helpers/show_action_alert.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  final SocketService socketService;
  final AuthService authService;
  const SettingsScreen(
      {required this.socketService, required this.authService, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeService = Provider.of<ThemeService>(context);
    bool isDarkMode = themeService.themeData.brightness == Brightness.dark;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          UserLabel(),
          const SizedBox(height: 20),
          SettingsLabel(
            icon: Icons.support_outlined,
            title: 'Support',
            topRadius: 15,
            onTap: () => Navigator.of(context).pushNamed('profile-details'),
          ),
          Container(
            color: theme.dividerColor,
            child: const Divider(height: 0.0),
          ),
          SettingsLabel(
            icon: Icons.security,
            title: 'Security',
            onTap: () {},
          ),
          Container(
            color: theme.dividerColor,
            child: const Divider(height: 0.0),
          ),
          SettingsLabelSwitch(
            icon: Icons.dark_mode_outlined,
            title: 'Dark mode',
            color: theme.hintColor,
            value: isDarkMode,
            onChanged: (value) {
              if (value) {
                themeService.setDarkMode();
              } else {
                themeService.setLightMode();
              }
            },
          ),
          Container(
            color: theme.dividerColor,
            child: const Divider(height: 0.0),
          ),
          SettingsLabel(
            icon: Icons.exit_to_app,
            title: 'Log out',
            color: ChatColors.rose,
            bottomRadius: 15,
            onTap: () {
              showActionAlert(
                  context, 'Do you want to log out?', 'Exit', ChatColors.rose,
                  () {
                Navigator.of(context).pop();
                socketService.disconnect();
                Navigator.pushReplacementNamed(context, 'login');
                AuthService.deleteToken();
              });
            },
          ),
        ],
      ),
    );
  }
}
