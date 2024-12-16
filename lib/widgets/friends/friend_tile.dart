import 'package:chat_app/services/chat_service.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/services/friends_service.dart';

import 'package:chat_app/models/friend.dart';
import 'package:provider/provider.dart';

class FriendTile extends StatefulWidget {
  final Friend friend;
  final FriendsService friendService;
  final Function()? loadFriends;
  final bool isRequest;
  final bool isRequestSent;
  const FriendTile({
    required this.friend, 
    required this.friendService,
    this.loadFriends = null,
    this.isRequest = false,
    this.isRequestSent = false,
    super.key,
  });

  @override
  State<FriendTile> createState() => _FriendTileState();
}

class _FriendTileState extends State<FriendTile> {
  // TODO: Eliminar loadFriends, friendService y volverlo un StatelessWidget
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String response = '';

    return ListTile(
      tileColor: theme.primaryColor,
      title: Text(
        widget.friend.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        widget.friend.email,
        style: TextStyle(color: theme.hintColor),
      ),
      onTap: !widget.isRequest && !widget.isRequestSent ? () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.uid = widget.friend.uid;
        chatService.name = widget.friend.name;
        chatService.online = widget.friend.online;

        Navigator.pushNamed(context, 'chat');
      } : null,
      leading: Stack(
        children: [
          CircleAvatar(
            backgroundColor: theme.secondaryHeaderColor,
            child: Text(
              widget.friend.name.substring(0, 2),
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
                color: widget.friend.online ? theme.focusColor : theme.hintColor,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: theme.primaryColor, width: 2),
              ),
            ),
          ),
        ],
      ),
      trailing: widget.isRequest ? 
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.check_circle_outline),
            color: theme.focusColor,
            onPressed: () async {
              widget.friendService.respondFriendRequest(widget.friend.uid, true);
              widget.loadFriends;
            },
          ),
          IconButton(
            icon: Icon(Icons.cancel_outlined),
            color: theme.indicatorColor,
            onPressed: () async {
              response = await widget.friendService.respondFriendRequest(widget.friend.uid, false);
              await widget.loadFriends;
            },
          ),
        ],
      ) : widget.isRequestSent ?
      IconButton(icon: Icon(Icons.cancel), color: theme.indicatorColor, onPressed: (){}) :
      Icon(Icons.navigate_next),
    );
  }
}