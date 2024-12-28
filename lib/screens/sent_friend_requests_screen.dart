import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/users_service.dart';
import 'package:chat_app/widgets/friends/friend_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SentFriendRequests extends StatelessWidget {
  const SentFriendRequests({super.key});

  @override
  Widget build(BuildContext context) {
    final friendsService = Provider.of<UsersService>(context);
    //List<User> sentFriendRequests = []; 
    final RefreshController _refreshController = RefreshController(initialRefresh: true);
    final theme = Theme.of(context);

    void _loadSentFriendRequests() async {
      await friendsService.getSentFriendRequests();
      _refreshController.refreshCompleted();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondaryHeaderColor,
        elevation: 1,
        centerTitle: false,
        title: Text('Sent Friend Requests', style: const TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadSentFriendRequests,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: theme.highlightColor,
          ),
          waterDropColor: theme.highlightColor,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: friendsService.sentFriendRequests.length,
          itemBuilder:(_, i) => FriendTile(
            friend: friendsService.sentFriendRequests[i],
            isRequestSent: true,
          ),
        ),
      ),
    );
  }
}