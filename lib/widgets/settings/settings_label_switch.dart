import 'package:flutter/material.dart';

class SettingsLabelSwitch extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final double topRadius;
  final double bottomRadius;
  final bool value;
  final Function(bool value) onChanged;

  const SettingsLabelSwitch({
    required this.icon,
    required this.title,
    required this.color,
    this.topRadius = 0,
    this.bottomRadius = 0,
    required this.value,
    required this.onChanged,
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
      //textColor: color,
      //iconColor: color,
      leading: Icon(icon),
      title: Text(title),
      trailing: Switch(value: value, onChanged: onChanged),
    );
  }
}
