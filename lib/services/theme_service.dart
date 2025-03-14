import 'package:flutter/material.dart';

import 'package:chat_app/global/chat_colors.dart';
import 'package:chat_app/global/storage_manager.dart';

class ThemeService with ChangeNotifier {
  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ChatColors.primaryDark,
    shadowColor: ChatColors.white,
    secondaryHeaderColor: ChatColors.secondaryDark,
    cardColor: ChatColors.secondaryDark,
    dividerColor: ChatColors.secondaryDark,
    highlightColor: ChatColors.contrast,
    hintColor: ChatColors.grayDark,
    focusColor: ChatColors.mint,
    indicatorColor: ChatColors.rose,
    scaffoldBackgroundColor: ChatColors.primaryDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: ChatColors.primaryDark,
      surfaceTintColor: ChatColors.primaryDark,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: ChatColors.grayDark),
      bodyLarge: TextStyle(color: ChatColors.white),
      bodyMedium: TextStyle(color: ChatColors.grayDark),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: ChatColors.secondaryDark,
      surfaceTintColor: ChatColors.secondaryDark,
      titleTextStyle: TextStyle(color: ChatColors.white),
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: ChatColors.secondaryDark,
      subtitleTextStyle: TextStyle(color: ChatColors.grayDark),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all<Color>(ChatColors.secondaryDark),
      trackColor: WidgetStateProperty.all<Color>(ChatColors.contrast),
      trackOutlineColor: WidgetStateProperty.all<Color>(ChatColors.primaryDark),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(ChatColors.contrast),
        textStyle: WidgetStateProperty.all<TextStyle>(TextStyle(color: ChatColors.grayLight2))
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: ChatColors.secondaryDark,
      //fillColor: Colors.transparent,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 12.0,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ChatColors.secondaryDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    )
  );

  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ChatColors.primaryLight,
    shadowColor: ChatColors.black,
    secondaryHeaderColor: ChatColors.secondaryLight,
    cardColor: ChatColors.secondaryLight,
    dividerColor: ChatColors.secondaryLight,
    highlightColor: ChatColors.contrast,
    hintColor: ChatColors.grayLight,
    focusColor: ChatColors.mint,
    indicatorColor: ChatColors.rose,
    scaffoldBackgroundColor: ChatColors.primaryLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: ChatColors.primaryLight,
      surfaceTintColor: ChatColors.primaryLight,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: ChatColors.grayLight),
      bodyLarge: TextStyle(color: ChatColors.grayLight2),
      bodyMedium: TextStyle(color: ChatColors.black),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: ChatColors.secondaryLight,
      surfaceTintColor: ChatColors.secondaryLight,
      titleTextStyle: TextStyle(color: ChatColors.black),
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: ChatColors.secondaryLight,
      subtitleTextStyle: TextStyle(color: ChatColors.grayLight2),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all<Color>(ChatColors.contrast),
      trackColor: WidgetStateProperty.all<Color>(ChatColors.secondaryLight),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(ChatColors.contrast),
        textStyle: WidgetStateProperty.all<TextStyle>(TextStyle(color: ChatColors.grayLight2))
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: ChatColors.secondaryLight.withOpacity(0.5),
      //fillColor: Colors.transparent,
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

  late ThemeData _themeData = lightTheme;
  ThemeData get themeData => _themeData;

  ThemeService() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
