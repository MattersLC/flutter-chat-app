import 'package:chat_app/screens/friend_requests_screen.dart';
import 'package:chat_app/screens/friends_screen.dart';
import 'package:chat_app/screens/find_screen.dart';
import 'package:chat_app/screens/sent_friend_requests.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/loading_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/screens/home_screen.dart';
//import 'package:chat_app/screens/users_screen.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'loading': (_) => const LoadingScreen(),
  'login': (_) => const LoginScreen(),
  'register': (_) => const RegisterScreen(),
  'home': (_) => const HomeScreen(),
  'contacts': (_) => const FriendsScreen(),
  'chat': (_) => const ChatScreen(),
  'find': (_) => const FindScreen(),
  'friend-requests': (_) => FriendRequestsScreen(),
  'sent-friend-requests': (_) => SentFriendRequests(),
};
