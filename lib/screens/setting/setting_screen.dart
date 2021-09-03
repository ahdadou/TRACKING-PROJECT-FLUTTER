import 'package:delivery/shared/components/default_button.dart';
import 'package:delivery/shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:delivery/services/repositories/LoginRepository.dart'
    as authRepository;

class SeetingPage extends StatefulWidget {
  const SeetingPage({ Key key }) : super(key: key);

  @override
  _ScreenPageState createState() => _ScreenPageState();
}

class _ScreenPageState extends State<SeetingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DefaultButton(
            color: kPrimaryColor,
            title: "LOGOUT",
            press: (){
authRepository.logout();
            },
            icon: null,
        )

          
        
      ),
      
    );
  }
}