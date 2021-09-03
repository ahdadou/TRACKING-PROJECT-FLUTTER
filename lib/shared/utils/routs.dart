import 'package:delivery/screens/home/home_screen.dart';
import 'package:delivery/screens/inbox/inbox_screen.dart';
import 'package:delivery/screens/information/information_screen.dart';
import 'package:delivery/screens/login/login_page.dart';
import 'package:delivery/screens/profile/profile_screen.dart';
import 'package:delivery/screens/root/root_app.dart';
import 'package:flutter/cupertino.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => new HomeScreen(),
  RootPage.routeName: (context) => new RootPage(),
  ProfileScreen.routeName: (context) => new ProfileScreen(),
  LoginScreen.routeName: (context) => new LoginScreen(),
  InfoScreen.routeName: (context) => new InfoScreen(),
  InboxPage.routeName: (context) => new InboxPage(),
};
