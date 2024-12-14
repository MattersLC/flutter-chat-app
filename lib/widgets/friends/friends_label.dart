import 'package:chat_app/global/chat_colors.dart';
import 'package:flutter/material.dart';

class FriendsLabel extends StatelessWidget {
  final IconData icon;
  final String title;
  final int amount;
  final Color? color;
  final double topRadius;
  final double bottomRadius;
  final Function() onTap;
  const FriendsLabel({
    required this.icon,
    required this.title,
    required this.amount,
    this.color,
    this.topRadius = 0,
    this.bottomRadius = 0,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topRadius),
            topRight: Radius.circular(topRadius),
            bottomLeft: Radius.circular(bottomRadius),
            bottomRight: Radius.circular(bottomRadius),
          ),
        ),
        onTap: onTap,
        textColor: color,
        iconColor: color,
        leading: Icon(icon),
        title: Text(title),
        //trailing: const Icon(Icons.navigate_next),
        trailing: Container(
          decoration: BoxDecoration(
            color: ChatColors.rose,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(amount.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              //const Icon(Icons.navigate_next, size: 16),
              const Icon(Icons.navigate_next, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
