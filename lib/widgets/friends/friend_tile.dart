import 'package:chat_app/helpers/show_action_alert.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/services/users_service.dart';

import 'package:chat_app/models/user.dart';
import 'package:provider/provider.dart';

class FriendTile extends StatelessWidget {
  final User friend;
  final Function()? loadFriends;
  final bool isRequest;
  final bool isRequestSent;
  const FriendTile({
    required this.friend,
    this.loadFriends = null,
    this.isRequest = false,
    this.isRequestSent = false,
    super.key,
  });

  // TODO: Eliminar loadFriends, friendService y volverlo un StatelessWidget
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final friendsService = Provider.of<UsersService>(context);
    String response = '';

    return ListTile(
      tileColor: theme.primaryColor,
      title: Text(
        friend.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        friend.email,
        style: TextStyle(color: theme.hintColor),
      ),
      onTap: !isRequest && !isRequestSent ? () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.uid = friend.uid;
        chatService.name = friend.name;
        chatService.online = friend.online;

        Navigator.pushNamed(context, 'chat');
      } : null,
      leading: Stack(
        children: [
          CircleAvatar(
            backgroundColor: theme.secondaryHeaderColor,
            child: Text(
              friend.name.substring(0, 2),
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
                color: friend.online ? theme.focusColor : theme.hintColor,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: theme.primaryColor, width: 2),
              ),
            ),
          ),
        ],
      ),
      trailing: isRequest ? 
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.check_circle_outline),
            color: theme.focusColor,
            onPressed: () async {
              showActionAlert(
                context,
                'Accept Friend Request?',
                'Accept',
                theme.focusColor,
                () async {
                  friendsService.respondFriendRequest(friend.uid, true);
                  loadFriends;
                  Navigator.of(context).pop();
                }
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.cancel_outlined),
            color: theme.indicatorColor,
            onPressed: () async {
              showActionAlert(
                context,
                'Reject Friend Request?',
                'Reject',
                theme.indicatorColor,
                () async {
                  response = await friendsService.respondFriendRequest(friend.uid, false);
                  await loadFriends;
                  Navigator.of(context).pop();
                }
              );
              //
            },
          ),
        ],
      ) : isRequestSent ?
      IconButton(icon: Icon(Icons.cancel), color: theme.indicatorColor, onPressed: (){}) :
      Icon(Icons.navigate_next),
    );
  }
}