import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';

class UserLabel extends StatelessWidget {
  final User user;
  final Function() onTap;
  const UserLabel({
    required this.user,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(user.email),
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: theme.primaryColor,
            child: Text(
              user.name.substring(0, 2),
              style: TextStyle(color: theme.highlightColor),
            ),
          ),
          onTap: () {
            //final chatService = Provider.of<ChatService>(context, listen: false);
            //chatService.userDestination = user;
    
            //Navigator.pushNamed(context, 'chat');
          },
        ),
        Container(
          color: theme.dividerColor,
          child: const Divider(height: 0.0),
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          leading: Icon(Icons.person_outline),
          title: Text('Ver perfil'),
          trailing: Icon(Icons.navigate_next),
          onTap: onTap,
        ),
      ],
    );
  }
}
