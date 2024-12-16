import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/services/friends_service.dart';

import 'package:chat_app/models/friend.dart';

import 'package:chat_app/widgets/friends/friend_tile.dart';

class FriendRequestsScreen extends StatelessWidget {
  const FriendRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final friendsService = Provider.of<FriendsService>(context);
    final theme = Theme.of(context);
    final RefreshController _refreshController = RefreshController(initialRefresh: false);

    void _loadFriendRequests() async {
      await friendsService.getFriendRequests();
      _refreshController.refreshCompleted();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondaryHeaderColor,
        elevation: 1,
        centerTitle: false,
        title: Text('Friend Requests', style: const TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: FutureBuilder<List<Friend>>(
        future: friendsService.getFriendRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final friendRequests = snapshot.data ?? [];
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              onRefresh: _loadFriendRequests,
              header: WaterDropHeader(
                complete: Icon(
                  Icons.check,
                  color: theme.highlightColor,
                ),
                waterDropColor: theme.highlightColor,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (_, i) => FriendTile(
                  friend: friendRequests[i],
                  friendService: friendsService,
                  loadFriends: _loadFriendRequests,
                  isRequest: true,
                ),
                itemCount: friendRequests.length,
              ),
            );
          }
        },
      ),
    );
  }
}


/*import 'package:chat_app/models/friend.dart';
import 'package:chat_app/services/friends_service.dart';
import 'package:chat_app/widgets/friends/friend_tile.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FriendRequestsScreen extends StatefulWidget {
  const FriendRequestsScreen({super.key});

  @override
  State<FriendRequestsScreen> createState() => _FriendRequestsScreenState();
}

class _FriendRequestsScreenState extends State<FriendRequestsScreen> {
  final friendsService = FriendsService();
  List<Friend> friendRequests = [];
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    _loadFriendRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondaryHeaderColor,
        elevation: 1,
        centerTitle: false,
        title: Text('Friend Requests', style: const TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadFriendRequests,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: theme.highlightColor,
          ),
          waterDropColor: theme.highlightColor,
        ),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (_, i) => FriendTile(
        friend: friendRequests[i],
        friendService: friendsService,
        loadFriends: _loadFriendRequests,
        isRequest: true,
      ),
      itemCount: friendRequests.length,
    );
  }

  void _loadFriendRequests() async {
    friendRequests = await friendsService.getFriendRequests();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}*/