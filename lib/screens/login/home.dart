import 'package:delivery/shared/components/default_button.dart';
import 'package:delivery/shared/utils/constants.dart';
import 'package:delivery/shared/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [kPrimaryColor, kPrimaryColor.withOpacity(0.6)])),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 50),
                  height: context.height * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/text2.png",
                        height: 130,
                      ),
                      Text("WELCOME TO PIGEONMAN",
                          style: GoogleFonts.montserrat(
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                              color: Colors.white)),
                    ],
                  ),
                ),
                Container(
                  height: context.height * 0.6,
                  width: context.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(80),
                          topRight: Radius.circular(80))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 10),
                          child: DefaultButton(
                            press: () {
                              print("facebook");
                            },
                            title: "Continue with Facebook",
                            icon: "assets/icons/facebook.svg",
                            color: Color(0xFF4267b2),
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 10),
                          child: DefaultButton(
                            press: () {
                              print("google");
                            },
                            title: "Continue with Google",
                            icon: "assets/icons/google.svg",
                            color: Color(0xFF4285F4),
                          )),
                      Spacer(),
                      Text(
                        "Social login will not post anything to your timeline",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
