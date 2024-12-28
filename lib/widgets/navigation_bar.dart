import 'dart:io';

import 'package:chat_app/global/chat_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
//import 'package:chat_app/global/theme.dart';

class GNavigationBar extends StatelessWidget {
  final ValueNotifier<int> currentScreen;
  const GNavigationBar({required this.currentScreen, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.secondaryHeaderColor,
      padding: Platform.isIOS
          ? const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 10.0, bottom: 25.0)
          : const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: GNav(
        backgroundColor: Colors.transparent,
        color: theme.textTheme.bodyLarge?.color ?? ChatColors.black,
        activeColor: ChatColors.contrast,
        tabBackgroundColor: theme.primaryColor,
        gap: 8,
        onTabChange: (index) {
          currentScreen.value = index;
        },
        padding: const EdgeInsets.all(16),
        selectedIndex: currentScreen.value,
        tabs: [
          GButton(
            icon: Icons.message_outlined,
            text: 'Chats',
          ),
          GButton(
            icon: Icons.phone_outlined,
            text: 'Calls',
          ),
          GButton(
            icon: Icons.people_alt_outlined,
            text: 'Friends',
          ),
          GButton(
            icon: Icons.public,
            text: 'Find',
          ),
          GButton(
            icon: Icons.settings,
            text: 'Settings',
          ),
        ],
      ),
    );
  }
}
