import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';

class UserLabel extends StatelessWidget {
  final User user;
  const UserLabel({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          ListTile(
            tileColor: Colors.transparent,
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
            tileColor: Colors.transparent,
            leading: Icon(Icons.person_outline),
            title: Text('Ver perfil'),
            trailing: Icon(Icons.navigate_next),
          ),
          /*Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Ver perfil'),
                InkWell(
                  onTap: () {},
                  child: Icon(Icons.navigate_next),
                )
              ],
            ),
          )*/
        ],
      ),
    );
  }
}
