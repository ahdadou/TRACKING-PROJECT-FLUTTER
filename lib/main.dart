import 'package:delivery/screens/home/home_screen.dart';
import 'package:delivery/screens/login/login_page.dart';
import 'package:delivery/screens/root/root_app.dart';
import 'package:delivery/shared/utils/routs.dart';
import 'package:delivery/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MaterialApp(
      title: 'PeigonMan',
      debugShowCheckedModeBanner: false,
      // darkTheme: darkThemeData(context),
      theme: lightThemeData(context),
      // home: RootApp(),
      initialRoute: LoginScreen.routeName,
      routes: routes,
    );
  }
}
