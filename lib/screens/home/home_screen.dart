import 'package:delivery/screens/home/home.dart';
import 'package:delivery/screens/notification/notification_screen.dart';
import 'package:delivery/services/blocs/delivery/delivery_bloc.dart';
import 'package:delivery/services/repositories/LoginRepository.dart';
import 'package:delivery/services/repositories/chatRepository.dart';
import 'package:delivery/services/repositories/deliveriesRepository.dart';
import 'package:delivery/services/repositories/reviewRepository.dart';
import 'package:delivery/shared/utils/bottom_navigation_bar_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int newReview = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatStompClient.activate();
    reviewStompClient.activate();
    listenToReview();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: getAppbar(),
      body: BlocProvider(
        create: (context) => DeliveryBloc()..add(fetchDeliveriesData()),
        child: Home(),
      ),
    );
  }

  getAppbar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                child: ClipOval(
                    child: tokenDto.value.image.toString() != null
                        ? Image.network(
                            tokenDto.value.image,
                            fit: BoxFit.cover,
                          )
                        : Container()),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationPage()));
                },
                child: Stack(
                  children: [
                    Container(
                      child: SvgPicture.asset(
                        notification['active'],
                        width: 25,
                        height: 25,
                      ),
                    ),
                    newReview > 0
                        ? Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                              child: Center(
                                child: Text(
                                  newReview.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ))
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  listenToReview(){
    newReview$.listen((value) {
      if(value) newReview+=1;
      else newReview=0;

      setState(() {
        
      });
    });
  }
}
