import 'package:delivery/screens/inbox/message_screen.dart';
import 'package:delivery/screens/search/search_screen.dart';
import 'package:delivery/shared/fakeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:delivery/shared/utils/size_config.dart';

class InboxPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<InboxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: getInboxBody(context),
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

  getInboxBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
            users.length,
            (index) => InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MessagesPage()));
                  },
                  child: Container(
                    width: context.width,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: Colors.grey.shade200))),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Image.network(
                            users[index].image,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                users[index].firstName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Hi How are u bro im you freg sges ..',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
      ),
    );
  }
}
