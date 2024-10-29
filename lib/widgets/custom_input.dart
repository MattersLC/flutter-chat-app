import 'package:chat_app/global/chat_colors.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  const CustomInput({
    required this.icon,
    required this.placeholder,
    required this.textController,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: ChatColors.secondaryLight,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 5),
            blurRadius: 5,
          )
        ],
      ),
      child: TextField(
        autocorrect: false,
        controller: textController,
        keyboardType: keyboardType,
        obscureText: isPassword,
        decoration: InputDecoration(
          fillColor: ChatColors.secondaryLight,
          filled: true,
          prefixIcon: Icon(icon),
          prefixIconColor: ChatColors.grayLight,
          hintText: placeholder,
          hintStyle: const TextStyle(color: ChatColors.grayLight),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 20.0,
          ),
        ),
      ),
    );
  }
}
