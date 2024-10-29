import 'package:flutter/material.dart';
import 'package:chat_app/global/chat_colors.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const LoginButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: ChatColors.mint,
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: Center(
          child: Text(
            text,
            style:
                const TextStyle(color: ChatColors.primaryLight, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
