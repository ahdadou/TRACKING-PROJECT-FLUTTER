import 'package:delivery/screens/home/home_screen.dart';
import 'package:delivery/screens/inbox/inbox_screen.dart';
import 'package:delivery/screens/map/map_screen.dart';
import 'package:delivery/screens/setting/setting_screen.dart';
import 'package:delivery/shared/utils/bottom_navigation_bar_json.dart';
import 'package:delivery/shared/utils/constants.dart';
import 'package:delivery/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RootPage extends StatefulWidget {
  static String routeName = "/rootPage";
  const RootPage({Key key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

// class _RootAppState extends State<RootPage> {
//   int _indexPage;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _indexPage=0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: getBody(),
//       bottomNavigationBar: getBottomNavigationBar(),
//     );
//   }

//   getBody() {
//     return IndexedStack(
//       index: _indexPage,
//       children: [
//         HomeScreen(),
//       InboxPage(),
//       SeetingPage()
//       ],
//     );
//   }

//   getBottomNavigationBar() {
//     return Container(
//       height: 70,
//       decoration: BoxDecoration(
//         border: Border(
//             top: BorderSide(
//                 width: 1, color: kContentColorLightTheme.withOpacity(0.1))),
//       ),
//       child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: List.generate(
//               icons.length,
//               (index) => IconButton(
//                     onPressed: () {
//                       setState(() {
//                         _indexPage = index;
//                       });
//                     },
//                     icon: Container(
//                       child: SvgPicture.asset(
//                         _indexPage == index
//                             ? icons[index]['active']
//                             : icons[index]['inactive'],
//                         width: 25,
//                         height: 25,
//                       ),
//                     ),
//                   ))),
//     );
//   }
// }

class _RootAppState extends State<RootPage> {
  var _selectedPageIndex;
  List<Widget> _pages;
  PageController _pageController;

  @override
  void initState() {
    super.initState();

    _selectedPageIndex = 0;

    _pages = [HomeScreen(), InboxPage(),MapScreen(), SeetingPage()];

    _pageController = PageController(initialPage: _selectedPageIndex);
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
          children: List.generate(
              icons.length,
              (index) => IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedPageIndex = index;
                        _pageController.jumpToPage(index);
                      });
                    },
                    icon: Container(
                      child: SvgPicture.asset(
                        _selectedPageIndex == index
                            ? icons[index]['active']
                            : icons[index]['inactive'],
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ))),
    );
  }
}
