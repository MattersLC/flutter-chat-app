import 'package:chat_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/global/chat_colors.dart';

class ChatAppBar extends AppBar {
  final String titleText;
  final ServerStatus status;
  ChatAppBar({
    super.key,
    required this.titleText,
    required this.status,
  }) : super(
          surfaceTintColor: ChatColors.primaryLight,
          centerTitle: false,
          title: Text(
            titleText,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          elevation: 1,
          backgroundColor: ChatColors.primaryLight,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: status == ServerStatus.Online
                  ? IconButton(
                      icon: Icon(Icons.offline_bolt),
                      color: ChatColors.mint, 
                      iconSize: 30,
                      onPressed: () {
                        print('clickkkk');
                      },
                    )
                  : const Icon(Icons.offline_bolt, color: Colors.red, size: 30),
            ),
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: const Icon(
                Icons.add_circle_outline,
                size: 30,
              ),
            ),
          ],
        );
}
