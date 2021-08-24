import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "/search";
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: Text("Search Page"),
    );
  }

  getAppbar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.grey.withOpacity(0.3)),
                child: Row(
                  children: [
                    Text(
                      "Search",
                      style: TextStyle(
                          color: Colors.grey.withOpacity(0.7),
                          fontWeight: FontWeight.w800),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
