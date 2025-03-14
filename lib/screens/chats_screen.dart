import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/widgets/avatar.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/services/chats_service.dart';

import 'package:chat_app/widgets/custom_search_bar.dart';
import 'package:chat_app/widgets/chats/chat_tile.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late ChatsService chatsService;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  late ThemeData theme;

  @override
  void initState() {
    super.initState();

    chatsService = Provider.of<ChatsService>(context, listen: false);

    _loadChats();
  }

  @override void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadChats,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: theme.highlightColor,
          ),
          waterDropColor: theme.highlightColor,
        ),
        child: _buildBody(theme),
      ),
    );
  }

  Widget _buildBody(ThemeData theme) {
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
          _buildPinnedChatsTitle(),
          _buildPinnedChats(),
          _buildChatsTitle(),
          _buildChats(),
        ],
      ),
    );
  }

  Widget _buildPinnedChatsTitle() {
    if (chatsService.pinnedChats.isEmpty) {
      return Container();
    }

    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'PINNED MESSAGES',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildPinnedChats() {
    if (chatsService.pinnedChats.isEmpty) {
      return Container();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: chatsService.pinnedChats.length,
      itemBuilder: (context, i) {
        return Slidable(
          key: Key(i.toString()),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  print('chat user to unpin: ${chatsService.pinnedChats[i].name}');
                  chatsService.unpinChat(chatsService.pinnedChats[i]);
                  setState(() {
                    
                  });
                },
                backgroundColor: theme.indicatorColor,
                foregroundColor: theme.primaryColor,
                icon: Icons.push_pin_outlined,
                label: 'Unpin',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  print('Swiped left');
                },
                backgroundColor: theme.indicatorColor,
                foregroundColor: theme.primaryColor,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: ChatTile(chat: chatsService.pinnedChats[i])
        );
      },
    );
  }

  Widget _buildChatsTitle() {
    if (chatsService.chats.isEmpty) {
      return Container();
    }

    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'ALL MESSAGES',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildChats() {
    if (chatsService.pinnedChats.isEmpty && chatsService.chats.isEmpty) {
      return Center(
        child: Container(
          alignment: Alignment.center,
          height: 300,
          child: Text('There\'s no chats yet'),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: chatsService.chats.length,
      itemBuilder: (context, i) {
        return Slidable(
          key: Key(i.toString()),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  print('chat user to pin: ${chatsService.chats[i].name}');
                  chatsService.pinChat(chatsService.chats[i]);
                  setState(() {
                    
                  });
                },
                backgroundColor: theme.focusColor,
                foregroundColor: theme.primaryColor,
                icon: Icons.push_pin_outlined,
                label: 'Pin',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                  ),
                  backgroundColor: theme.primaryColor,
                  builder: (context) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          topRight: const Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Avatar(
                                profilePicture: chatsService.chats[i].profilePicture,
                                name: chatsService.chats[i].name,
                                radius: 20,
                                background: theme.secondaryHeaderColor,
                                foreground: theme.hintColor,
                                showStatus: true,
                                status: chatsService.chats[i].online,
                              ),

                            ],
                          )
                        ],
                      ),
                    );
                  }
                ),
                backgroundColor: theme.secondaryHeaderColor,
                foregroundColor: theme.shadowColor,
                icon: Icons.more_horiz,
                label: 'More',
              ),
              SlidableAction(
                onPressed: (context) {
                  // Action for swiping left
                  print('Swiped left');
                },
                backgroundColor: theme.indicatorColor,
                foregroundColor: theme.primaryColor,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: ChatTile(chat: chatsService.chats[i])
        );
      },
    );
  }

  void _loadChats() async {
    await chatsService.getChats();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
