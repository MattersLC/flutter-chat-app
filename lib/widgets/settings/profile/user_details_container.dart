import 'package:flutter/material.dart';

class UserDetailsContainer extends StatelessWidget {
  final String header;
  final String content;
  final Function() onTap;
  const UserDetailsContainer({
    required this.header,
    required this.content,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 20),
      //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: theme.secondaryHeaderColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(header),
              ),
              IconButton(
                onPressed: onTap,
                icon: Icon(Icons.edit),
                iconSize: 16,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: Text(
              content,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}