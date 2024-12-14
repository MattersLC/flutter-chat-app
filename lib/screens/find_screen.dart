import 'package:chat_app/global/chat_colors.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/users_service.dart';
import 'package:chat_app/widgets/custom_search_bar.dart';
import 'package:chat_app/widgets/find/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FindScreen extends StatefulWidget {
  const FindScreen({super.key});

  @override
  State<FindScreen> createState() => _FindScreenState();
}

class _FindScreenState extends State<FindScreen> {
  final usersService = UsersService();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<User> users = [];

  @override
  void initState() {
    _loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadUsers,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Theme.of(context).highlightColor,
          ),
          waterDropColor: Theme.of(context).highlightColor,
        ),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomSearchBar(
            label: 'Search user...',
          ),
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (_, i) => UserTile(user: users[i]),
        ),
      ],
    );
  }

  void _loadUsers() async {
    users = await usersService.getUsers();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
