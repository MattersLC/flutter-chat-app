import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Avatar extends StatelessWidget {
  final String profilePicture;
  final String name;
  final double radius;
  final Color? background;
  final Color? foreground;
  final bool showStatus;
  final bool status;
  const Avatar({
    super.key,
    required this.profilePicture,
    required this.name,
    required this.radius,
    this.background,
    this.foreground,
    this.showStatus = false,
    this.status = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: background ?? theme.primaryColor,
          child: profilePicture != '' ?
          ClipOval(
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: radius * 2,
              height: radius * 2,
              progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageUrl: profilePicture,
            ),
          )
            :
          Text(
            name.substring(0, 2),
            style: TextStyle(color: foreground ?? theme.highlightColor),
          ),
        ),
        if (showStatus) ... [
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: status ? theme.focusColor : theme.hintColor,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: theme.secondaryHeaderColor, width: 2),
              ),
            ),
          ),
        ]
      ],
    );
  }
}