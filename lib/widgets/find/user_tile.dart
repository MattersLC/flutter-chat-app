import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/global/chat_colors.dart';

import 'package:chat_app/helpers/show_action_alert.dart';

import 'package:chat_app/models/user.dart';

import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/friend_request_service.dart';

class UserTile extends StatefulWidget {
  final User user;
  const UserTile({required this.user, super.key});

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  bool requestSent = false;

  void _sendFriendRequest(BuildContext context) async {
    final friendRequestService =
        Provider.of<FriendRequestService>(context, listen: false);
    bool success =
        await friendRequestService.sendFriendRequest(widget.user.uid);
    if (success) {
      setState(() {
        requestSent = true;
      });
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      tileColor: theme.primaryColor,
      title: Text(
        widget.user.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        widget.user.about,
        style: TextStyle(color: theme.hintColor),
      ),
      leading: Stack(
        children: [
          CircleAvatar(
            backgroundColor: ChatColors.secondaryLight,
            child: Text(
              widget.user.name.substring(0, 2),
              style: TextStyle(color: theme.hintColor),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: widget.user.online ? ChatColors.mint : theme.hintColor,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: ChatColors.primaryLight, width: 2),
              ),
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: requestSent
            ? const Icon(Icons.person_add_disabled, color: ChatColors.grayLight)
            : const Icon(Icons.person_add_alt, color: ChatColors.contrast),
        onPressed: requestSent
            ? null
            : () => showActionAlert(
                  context,
                  'Add contact?',
                  'Add',
                  ChatColors.contrast,
                  () => _sendFriendRequest(context),
                ),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userDestination = widget.user;

        Navigator.pushNamed(context, 'chat');
      },
    );
  }
}
