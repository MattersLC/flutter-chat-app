import 'package:chat_app/models/friend.dart';
import 'package:chat_app/services/friends_service.dart';
import 'package:chat_app/widgets/custom_search_bar.dart';
import 'package:chat_app/widgets/friends/friends_label.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final friendsService = Provider.of<FriendsService>(context);
    final theme = Theme.of(context);
    final RefreshController _refreshController = RefreshController(initialRefresh: false);

    void _loadFriends() async {
      await friendsService.getFriends();
      await friendsService.getTotalFriendRequests();
      await friendsService.getTotalSentFriendRequests();
      _refreshController.refreshCompleted();
    }

    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([
          friendsService.getFriends(),
          friendsService.getTotalFriendRequests(),
          friendsService.getTotalSentFriendRequests(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final friends = friendsService.friendRequests; // Update this as needed for friends
            final totalFriendRequests = snapshot.data![1] as int;
            final totalSentFriendRequests = snapshot.data![2] as int;
            return SmartRefresher(
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
              child: _buildBody(
                friends: friends,
                totalFriendRequests: totalFriendRequests,
                totalSentFriendRequests: totalSentFriendRequests,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildBody({
    required List<Friend> friends,
    required int totalFriendRequests,
    required int totalSentFriendRequests,
  }) {
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
            onTap: () {},//=> Navigator.of(context).pushNamed('friend-requests'),
          ),
          FriendsLabel(
            icon: Icons.person_add_alt_1, 
            title: 'Sent friend requests',
            amount: totalSentFriendRequests,
            bottomRadius: 15,
            onTap: () {},//=> Navigator.of(context).pushNamed('sent-friend-requests'),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: friends.length,
            itemBuilder: (_, i) => ListTile(title: Text(friends[i].name),),
          ),
        ],
      ),
    );
  }
}


/*import 'package:chat_app/models/friend.dart';
import 'package:chat_app/services/friends_service.dart';
import 'package:chat_app/widgets/custom_search_bar.dart';
import 'package:chat_app/widgets/friends/friends_label.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final friendsService = FriendsService();
  List<Friend> friends = [];
  int totalFriendRequests = 0;
  int totalSentFriendRequests = 0;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  
  @override
  void initState() {
    _loadFriends();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            physics: const NeverScrollableScrollPhysics(),
            itemCount: friends.length,
            itemBuilder: (_, i) => ListTile(title: Text(friends[i].name),),
          ),
        ],
      ),
    );
  }

  ListView _listViewFriends() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) => ListTile(title: Text(friends[i].name),),
      itemCount: friends.length,
    );
  }

  void _loadFriends() async {
    friends = await friendsService.getFriends();
    totalFriendRequests = await friendsService.getTotalFriendRequests();
    totalSentFriendRequests = await friendsService.getTotalSentFriendRequests();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}*/