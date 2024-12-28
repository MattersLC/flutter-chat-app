import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/models/user.dart';

import 'package:chat_app/services/users_service.dart';

import 'package:chat_app/widgets/custom_search_bar.dart';
import 'package:chat_app/widgets/friends/friend_tile.dart';
import 'package:chat_app/widgets/friends/friends_label.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  //final friendsService = UsersService();
  //List<User> friends = [];
  //int totalFriendRequests = 0;
  //int totalSentFriendRequests = 0;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  
  @override
  void initState() {
    _loadFriends();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final friendsService = Provider.of<UsersService>(context);

    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadFriends,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: theme.highlightColor,
          ),
          waterDropColor: theme.highlightColor,
        ),
        child: _buildBody(friendsService.friends, friendsService.totalFriendRequests, friendsService.totalSentFriendRequests),
      ),
    );
  }

  Widget _buildBody(List<User> friends, int totalFriendRequests, int totalSentFriendRequests) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CustomSearchBar(
              label: 'Search friend...',
            ),
          ),
          const SizedBox(height: 20),
          FriendsLabel(
            icon: Icons.timer_outlined, 
            title: 'Friend requests',
            amount: totalFriendRequests,
            topRadius: 15,
            onTap: () => Navigator.of(context).pushNamed('friend-requests'),
          ),
          FriendsLabel(
            icon: Icons.person_add_alt_1, 
            title: 'Sent friend requests',
            amount: totalSentFriendRequests,
            bottomRadius: 15,
            onTap: () => Navigator.of(context).pushNamed('sent-friend-requests'),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, i) => FriendTile(
              friend: friends[i],
            ),
            itemCount: friends.length,
          ),
        ],
      ),
    );
  }

  void _loadFriends() async {
    final friendsService = Provider.of<UsersService>(context, listen: false);
    await friendsService.getFriends();
    await friendsService.getTotalFriendRequests();
    await friendsService.getTotalSentFriendRequests();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}