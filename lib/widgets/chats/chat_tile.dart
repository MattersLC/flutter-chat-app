import 'package:chat_app/global/chat_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/models/chat.dart';
import 'package:chat_app/services/chat_service.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;
  const ChatTile({required this.chat, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      tileColor: theme.primaryColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            chat.user.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            '22:15',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            chat.lastMessage,
            style: TextStyle(color: ChatColors.grayLight),
          ),
          Icon(
            Icons.check,
            size: 20,
            color: ChatColors.grayLight,
          ),
        ],
      ),
      leading: Stack(
        children: [
          CircleAvatar(
            backgroundColor: theme.secondaryHeaderColor,
            child: Text(
              chat.user.name.substring(0, 2),
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
                color:
                    chat.user.online ? ChatColors.mint : theme.hintColor,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: ChatColors.primaryLight, width: 2),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        //chatService.userDestination = chat.user;
        chatService.uid = chat.user.uid;
        chatService.name = chat.user.name;
        chatService.online = chat.user.online;

        Navigator.pushNamed(context, 'chat');
      },
    );
  }
}
