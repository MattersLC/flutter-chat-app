import 'package:chat_app/services/friends_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SentFriendRequests extends StatefulWidget {
  const SentFriendRequests({super.key});

  @override
  State<SentFriendRequests> createState() => _SentFriendRequestsState();
}

class _SentFriendRequestsState extends State<SentFriendRequests> {
  @override
  Widget build(BuildContext context) {
    final friendsService = Provider.of<FriendsService>(context);
    return const Placeholder();
  }
}