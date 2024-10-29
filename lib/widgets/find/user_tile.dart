import 'package:chat_app/global/chat_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/chat_service.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        user.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        user.about,
        style: const TextStyle(color: ChatColors.grayLight),
      ),
      leading: Stack(
        children: [
          CircleAvatar(
            backgroundColor: ChatColors.secondaryLight,
            child: Text(
              user.name.substring(0, 2),
              style: const TextStyle(color: ChatColors.grayLight),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: user.online ? ChatColors.mint : ChatColors.grayLight,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: ChatColors.primaryLight, width: 2),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userDestination = user;

        Navigator.pushNamed(context, 'chat');
      },
    );
  }
}
