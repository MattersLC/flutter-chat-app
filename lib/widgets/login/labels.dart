import 'package:chat_app/global/chat_colors.dart';
import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final String question;
  final String actionText;
  const Labels({
    super.key,
    required this.route,
    required this.question,
    required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          question,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, route);
          },
          child: Text(
            actionText,
            style: const TextStyle(
              color: ChatColors.mint,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
