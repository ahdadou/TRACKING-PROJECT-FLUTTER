import 'dart:ui';

import 'package:delivery/screens/home/home_screen.dart';
import 'package:delivery/screens/inbox/inbox_screen.dart';
import 'package:delivery/screens/map/map_screen.dart';
import 'package:delivery/screens/setting/setting_screen.dart';
import 'package:delivery/shared/utils/bottom_navigation_bar_json.dart';
import 'package:delivery/shared/utils/constants.dart';
import 'package:delivery/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:delivery/services/repositories/chatRepository.dart'
    as chatRepository;

class RootPage extends StatefulWidget {
  static String routeName = "/rootPage";
  const RootPage({Key key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootPage> {
  int newMessage = 0;
  var _selectedPageIndex;
  List<Widget> _pages;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = 0;
    _pages = [HomeScreen(), InboxPage(), MapScreen(), SeetingPage()];
    _pageController = PageController(initialPage: _selectedPageIndex);
    listenToChat();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  getBody() {
    return PageView(
      controller: _pageController,
      //The following parameter is just to prevent
      //the user from swiping to the next page.
      physics: NeverScrollableScrollPhysics(),
      children: _pages,
    );
  }

  getBottomNavigationBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
                width: 1, color: kContentColorLightTheme.withOpacity(0.1))),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedPageIndex = 0;
                  _pageController.jumpToPage(0);
                });
              },
              icon: Container(
                child: SvgPicture.asset(
                  _selectedPageIndex == 0
                      ? icons[0]['active']
                      : icons[0]['inactive'],
                  width: 25,
                  height: 25,
                ),
              ),
            ),
            Stack(
              children: [
          
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedPageIndex = 1;
                      _pageController.jumpToPage(1);
                    });
                  },
                  icon: Container(
                    child: SvgPicture.asset(
                      _selectedPageIndex == 1
                          ? icons[1]['active']
                          : icons[1]['inactive'],
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
                 newMessage>0? Positioned(
                  right: 3,
                  top: 3,
                    child: Container(
                  width: 20,
                  height: 20,
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      newMessage.toString(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )):Container()
              ],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedPageIndex = 2;
                  _pageController.jumpToPage(2);
                });
              },
              icon: Container(
                child: SvgPicture.asset(
                  _selectedPageIndex == 2
                      ? icons[2]['active']
                      : icons[2]['inactive'],
                  width: 25,
                  height: 25,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedPageIndex = 3;
                  _pageController.jumpToPage(3);
                });
              },
              icon: Container(
                child: SvgPicture.asset(
                  _selectedPageIndex == 3
                      ? icons[3]['active']
                      : icons[3]['inactive'],
                  width: 25,
                  height: 25,
                ),
              ),
            )
          ]),
    );
  }

  listenToChat() {
    chatRepository.newMessages$.listen((value) {
      print("7868666666666767868756666666666666");
      if (value) {
        this.newMessage += 1;
      } else {
        this.newMessage = 0;
      }
      setState(() {
        
      });
    });
  }
}
