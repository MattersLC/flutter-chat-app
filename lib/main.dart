import 'package:chat_app/services/chats_service.dart';
import 'package:chat_app/services/storage/storage_service.dart';
import 'package:chat_app/services/users_service.dart';
import 'package:chat_app/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/routes/routes.dart';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/chat_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//void main() => runApp(const MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

/**/

class MyApp extends StatefulWidget {
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => ChatService()),
        ChangeNotifierProvider(create: (_) => ChatsService()),
        ChangeNotifierProvider(create: (_) => UsersService()),
        ChangeNotifierProvider(create: (_) => StorageService()),
      ],
      child: Consumer<ThemeService>(
        builder: (context, themeService, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeService.themeData,
            title: 'Chat App',
            initialRoute: 'loading',
            routes: appRoutes,
          );
        },
      ),
    );
  }
}
