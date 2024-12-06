import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/auth_service.dart';

import 'package:chat_app/screens/find_screen.dart';
import 'package:chat_app/screens/settings_screen.dart';
import 'package:chat_app/screens/chats_screen.dart';

import 'package:chat_app/widgets/navigation_bar.dart';
import 'package:chat_app/global/chat_colors.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';

//import 'package:chat_app/services/users_service.dart';
//import 'package:chat_app/services/chat_service.dart';

//import 'package:chat_app/models/user.dart';
//import 'package:chat_app/widgets/chat_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> indexScreen = ValueNotifier<int>(0);
  //final userService = UsersService();
  //late User user;

  //List<User> users = [];

  late AuthService authService;
  late SocketService socketService;

  List<String> titles = ['Chat', 'Calls', 'Contacts', 'Find', 'Settings'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authService = Provider.of<AuthService>(context);
    socketService = Provider.of<SocketService>(context);
    //user = authService.user!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: ValueListenableBuilder(
          valueListenable: indexScreen,
          builder: (context, index, child) {
            return Text(
              titles[indexScreen.value],
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            );
          },
        ),
        elevation: 1,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: socketService.serverStatus == ServerStatus.Online
                ? const Icon(Icons.offline_bolt,
                    color: ChatColors.mint, size: 30)
                : const Icon(Icons.offline_bolt, color: ChatColors.rose, size: 30),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const Badge(
              backgroundColor: ChatColors.rose,
              child: Icon(
                Icons.notifications,
                size: 30,
              ),
            ),
            /*child: const Icon(
              Icons.notifications,
              size: 30,
            ),*/
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: GNavigationBar(currentScreen: indexScreen),
    );
  }

  Widget _buildBody() {
    return ValueListenableBuilder(
      valueListenable: indexScreen,
      builder: (context, index, child) {
        switch (index) {
          case 0: // Chats
            return const ChatsSCreen();
          case 3:
            return const FindScreen();
          case 4:
            return SettingsScreen(
              socketService: socketService,
              authService: authService,
            );
          default: // Default
            return const Center(child: Text('Undefined screen'));
        }
      },
    );
  }
}
