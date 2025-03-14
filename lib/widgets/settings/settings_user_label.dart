import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/widgets/avatar.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/services/auth_service.dart';

class UserLabel extends StatelessWidget {
  const UserLabel({ super.key });

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
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
            '${authService.user!.name} ${authService.user!.lastName}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(authService.user!.about),
          leading: Avatar(
            profilePicture: authService.user!.profilePicture,
            name: authService.user!.name,
            radius: 30,
          ),
          /*leading: CircleAvatar(
            radius: 30,
            backgroundColor: theme.primaryColor,
            child: authService.user!.profilePicture != '' ?
            ClipOval(
              child: CachedNetworkImage(
                fit: BoxFit.cover, // Ensures the image covers the entire area 
                width: 60, // Match the CircleAvatar radius * 2 
                height: 60, // Match the CircleAvatar radius * 2
                imageUrl: authService.user!.profilePicture,
              ),
            )
             :
            Text(
              authService.user!.name.substring(0, 2),
              style: TextStyle(color: theme.highlightColor),
            ),
          ),*/
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
          title: Text('Profile details'),
          trailing: Icon(Icons.navigate_next),
          onTap: () => Navigator.of(context).pushNamed('profile-details'),
        ),
      ],
    );
  }
}
