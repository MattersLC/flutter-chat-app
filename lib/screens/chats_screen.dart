import 'package:chat_app/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chats_service.dart';
//import 'package:chat_app/services/users_service.dart';
//import 'package:chat_app/services/chat_service.dart';

import 'package:chat_app/models/user.dart';
import 'package:chat_app/models/chat.dart';
import 'package:chat_app/widgets/chats/chat_tile.dart';
import 'package:chat_app/global/chat_colors.dart';

class ChatsSCreen extends StatefulWidget {
  const ChatsSCreen({super.key});

  @override
  State<ChatsSCreen> createState() => _ChatsSCreenState();
}

class _ChatsSCreenState extends State<ChatsSCreen> {
  //final userService = UsersService();
  final chatsService = ChatsService();
  late User user;
  List<Chat> chats = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _loadChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    user = authService.user!;

    return Scaffold(
      //backgroundColor: ChatColors.primaryLight,
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadChats,
        header: const WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: ChatColors.mint,
          ),
          waterDropColor: ChatColors.mint,
        ),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CustomSearchBar(
              label: 'Search chat...',
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'PINNED MESSAGES',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, i) => ChatTile(chat: chats[i]),
            itemCount: chats.length,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'ALL MESSAGES',
              style: TextStyle(
                //color: ChatColors.grayLight,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: chats.length,
            itemBuilder: (context, i) {
              return Slidable(
                  key: Key(i.toString()),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          // Action for swiping right
                          print('Pinned - ${user.uid}');
                        },
                        backgroundColor: ChatColors.mint,
                        foregroundColor: ChatColors.primaryLight,
                        icon: Icons.push_pin_outlined,
                        label: 'Pin',
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          // Action for swiping left
                          print('Swiped left');
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ChatTile(chat: chats[i]));
            },
          )
        ],
      ),
    );
  }

  ListView _listViewUsers() {
    return ListView.builder(
      //physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) => ChatTile(chat: chats[i]),
      //separatorBuilder: (_, i) => Divider(),
      itemCount: chats.length,
    );
  }

  void _loadChats() async {
    chats = await chatsService.getChats();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
