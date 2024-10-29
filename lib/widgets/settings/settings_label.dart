import 'package:flutter/material.dart';

class SettingsLabel extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? color;
  final double topRadius;
  final double bottomRadius;
  final Function() onTap;
  const SettingsLabel({
    required this.icon,
    required this.title,
    this.color,
    this.topRadius = 0,
    this.bottomRadius = 0,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topRadius),
          topRight: Radius.circular(topRadius),
          bottomLeft: Radius.circular(bottomRadius),
          bottomRight: Radius.circular(bottomRadius),
        ),
      ),
      onTap: onTap,
      //textColor: color,
      //iconColor: color,
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.navigate_next),
    );
  }
}
