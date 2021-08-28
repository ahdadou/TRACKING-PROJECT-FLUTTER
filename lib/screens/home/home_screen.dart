import 'package:delivery/screens/home/home.dart';
import 'package:delivery/screens/search/search_screen.dart';
import 'package:delivery/shared/fakeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: Home(),
    );
  }

  getAppbar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                child: ClipOval(
                  child: Image.network(
                    profile,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 40,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.grey.withOpacity(0.3)),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/search.svg",
                        height: 20,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Search",
                        style: TextStyle(
                            color: Colors.grey.withOpacity(0.7),
                            fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
