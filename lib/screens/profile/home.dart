import 'package:delivery/shared/fakeData.dart';
import 'package:delivery/shared/utils/bottom_navigation_bar_json.dart';
import 'package:delivery/shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              const EdgeInsets.only(right: 20.0, left: 20, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipOval(
                    child: Image.network(
                      profile,
                      fit: BoxFit.cover,
                      height: 80,
                      width: 80,
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue[600]),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            size: 19,
                            color: Colors.white,
                          ),
                        ),
                      ))
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                height: 70,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(instagramName,
                          style: GoogleFonts.adventPro(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text(
                                '2654',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            // width: 100,
                            // height: 50,
                            child: RatingBarIndicator(
                              rating: users[0].avergeRate,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              unratedColor: Colors.amber.withAlpha(50),
                              direction: Axis.horizontal,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.blue[600],
                          ),
                          Text(
                            from,
                            style: TextStyle(
                              color: Colors.blue[600],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10, left: 20),
          child: Row(
            children: [
              Text(
                "Reviews",
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.reviews)
            ],
          ),
        ),
        Expanded(
            flex: 4,
            child: SingleChildScrollView(
                child: users.length > 0
                    ? Column(
                        children: List.generate(users.length, (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              // borderRadius: BorderRadius.circular(20),
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: Colors.grey.withOpacity(0.2)))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6.0, horizontal: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  instagramBio,
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ClipOval(
                                          child: Image.network(
                                            users[index].image,
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              users[index].firstName +
                                                  ' ' +
                                                  users[index].lastName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            ),
                                            Container(
                                              // width: 100,
                                              // height: 50,
                                              child: RatingBarIndicator(
                                                rating: users[index].avergeRate,
                                                itemBuilder: (context, index) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 20.0,
                                                unratedColor:
                                                    Colors.amber.withAlpha(50),
                                                direction: Axis.horizontal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "12/12/12:09:87",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.withOpacity(0.5)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }))
                    : Center(
                        child: Container(
                          child: Text("AUCUN"),
                        ),
                      ))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            onTap: () {
              print("pass chat");
            },
            child: Container(
              padding: EdgeInsets.all(20),
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Chat Now",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.chat, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
