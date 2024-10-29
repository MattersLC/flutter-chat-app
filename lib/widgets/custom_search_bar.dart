import 'package:flutter/material.dart';
import 'package:chat_app/global/chat_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final String label;
  const CustomSearchBar({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.secondaryHeaderColor,
        prefixIcon: const Icon(
          Icons.search,
          color: ChatColors.grayLight,
        ),
        labelText: label,
        labelStyle: const TextStyle(color: ChatColors.grayLight),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),
      ),
    );
  }
}
