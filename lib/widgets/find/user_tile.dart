import 'package:chat_app/models/send_friend_request_response.dart';
import 'package:chat_app/widgets/avatar.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/helpers/show_action_alert.dart';

import 'package:chat_app/models/user.dart';

//import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/users_service.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final friendsService = Provider.of<UsersService>(context, listen: false);
    final theme = Theme.of(context);

    bool requestSent = user.relationshipStatus == 'pending' ? true : false;

    Future<void> sendFriendRequest(BuildContext context) async { 
      SendFriendRequestResponse response = await friendsService.sendFriendRequest(user.uid); 
      if (response.ok) { 
        requestSent = true; 
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Friend request sent to ${user.name}')), 
        ); 
      } else { 
        ScaffoldMessenger.of(context).showSnackBar( 
          SnackBar(content: Text('Failed to send friend request')), 
        ); 
      } 
      Navigator.of(context).pop(); 
    } 
    
    Future<void> unsendFriendRequest(BuildContext context) async { 
      bool success = await friendsService.unsendFriendRequest(user.uid); 
      if (success) { 
        requestSent = false; 
        ScaffoldMessenger.of(context).showSnackBar( 
          SnackBar(content: Text('Friend request to ${user.name} cancelled')), 
        ); 
      } else { 
        ScaffoldMessenger.of(context).showSnackBar( 
          SnackBar(content: Text('Failed to cancel friend request')), 
        ); 
      } 
      Navigator.of(context).pop(); 
    } 
    
    Future<void> deleteFriend(BuildContext context) async { 
      bool success = await friendsService.deleteFriend(user.uid); 
      if (success) { 
        //user.isFriend = false;
        user.relationshipStatus = 'none';
        ScaffoldMessenger.of(context).showSnackBar( 
          SnackBar(content: Text('${user.name} has been removed from your friends')), 
        ); 
      } else { 
        ScaffoldMessenger.of(context).showSnackBar( 
          SnackBar(content: Text('Failed to remove friend')), 
        ); 
      } 
      Navigator.of(context).pop(); 
    }

    return ListTile(
      tileColor: theme.primaryColor,
      title: Text(
        '${user.name} ${user.lastName}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        user.about,
        style: TextStyle(color: theme.hintColor),
      ),
      leading: Avatar(
        profilePicture: user.profilePicture,
        name: user.name,
        radius: 25,
        background: theme.secondaryHeaderColor,
        foreground: theme.hintColor,
        showStatus: true,
        status: user.online,
      ),
      /*leading: Stack(
        children: [
          CircleAvatar(
            backgroundColor: theme.secondaryHeaderColor,
            child: Text(
              user.name.substring(0, 2),
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
                color: user.online ? theme.focusColor : theme.hintColor,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: theme.primaryColor, width: 2),
              ),
            ),
          ),
        ],
      ),*/
      trailing: user.relationshipStatus == 'friends' ?
      IconButton(
        onPressed: () => showActionAlert(
          context,
          'Delete ${user.name} as friend?',
          'Delete',
          theme.indicatorColor,
          () => deleteFriend(context),
        ),
        icon: Icon(Icons.person_off_outlined, color: theme.indicatorColor)
      ) : requestSent ?
      IconButton(
        onPressed: () => showActionAlert(
          context,
          'Unsend friend request to ${user.name}?',
          'Unsend',
          theme.indicatorColor,
          () => unsendFriendRequest(context),
        ),
        icon: Icon(Icons.person_remove_alt_1_outlined, color: theme.hintColor)
      ) :
      IconButton(
        onPressed: () => showActionAlert(
          context,
          'Sent friend request to ${user.name}?',
          'Add',
          theme.highlightColor,
          () => sendFriendRequest(context),
        ),
        icon: Icon(Icons.person_add_alt, color: theme.highlightColor),
      ),
      /*onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userDestination = widget.user;

        Navigator.pushNamed(context, 'chat');
      },*/
    );
  }
}
