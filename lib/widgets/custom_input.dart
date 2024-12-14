import 'package:chat_app/global/chat_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
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
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      //padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            offset: const Offset(0, 5),
            blurRadius: 5,
          )
        ],
      ),
      child: TextField(
        autocorrect: false,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword && _obscureText,
        decoration: InputDecoration(
          fillColor: Theme.of(context).cardColor,
          filled: true,
          prefixIcon: Icon(widget.icon),
          prefixIconColor: ChatColors.grayLight,
          suffixIcon: widget.isPassword ? IconButton(onPressed: _togglePasswordVisibility, icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility)) : null,
          suffixIconColor: ChatColors.grayLight,
          hintText: widget.placeholder,
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
