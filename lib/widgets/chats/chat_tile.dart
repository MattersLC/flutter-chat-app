import 'package:chat_app/global/chat_colors.dart';
import 'package:chat_app/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/models/chat.dart';
import 'package:chat_app/services/chat_service.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;
  const ChatTile({required this.chat, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String formatLastMessageTime(DateTime lastMessageTime) {
      final now = DateTime.now(); 
      final yesterday = now.subtract(Duration(days: 1));

      if (DateUtils.isSameDay(lastMessageTime, now)) {
        return DateFormat.Hm().format(lastMessageTime);
      } else if (DateUtils.isSameDay(lastMessageTime, yesterday)) {
        return 'yesterday';
      } else {
        return DateFormat('dd/MM/yyyy').format(lastMessageTime);
      }
    }
    
    return ListTile(
      tileColor: theme.primaryColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            chat.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            formatLastMessageTime(chat.lastMessageTime),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            chat.lastMessage,
            style: TextStyle(color: ChatColors.grayLight, fontSize: 14),
          ),
          Icon(
            Icons.check,
            size: 20,
            color: chat.lastMessageViewed ? theme.highlightColor : theme.hintColor,
          ),
        ],
      ),
      leading: Avatar(
        profilePicture: chat.profilePicture,
        name: chat.name,
        radius: 25,
        background: theme.secondaryHeaderColor,
        foreground: theme.hintColor,
        showStatus: true,
        status: chat.online,
      ),
      /*leading: Stack(
        children: [
          CircleAvatar(
            backgroundColor: theme.secondaryHeaderColor,
            child: Text(
              chat.name.substring(0, 2),
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
                    chat.online ? ChatColors.mint : theme.hintColor,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: ChatColors.primaryLight, width: 2),
              ),
            ),
          ),
        ],
      ),*/
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        //chatService.userDestination = chat.user;
        chatService.uid = chat.uid;
        chatService.name = chat.name;
        chatService.online = chat.online;

        Navigator.pushNamed(context, 'chat');
      },
    );
  }
}
