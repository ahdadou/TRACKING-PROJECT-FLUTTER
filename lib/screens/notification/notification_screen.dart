import 'package:delivery/services/blocs/notification/notification_bloc.dart';
import 'package:delivery/services/blocs/review/review_bloc.dart';
import 'package:delivery/services/repositories/reviewRepository.dart';
import 'package:delivery/shared/models/reviewResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:delivery/shared/utils/size_config.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newReview$.add(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => NotificationBloc()..add(FetchNotificationEvent()),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Notifications",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  if (state is FetchNotificationsSuccessState)
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                              children: List.generate(
                                  state.notifications.length, (index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 5,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                              ),
                              width: context.width,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    // spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      ClipOval(
                                          child: Image.network(
                                        state.notifications[index].user_sender
                                            .image,
                                        height: 40,
                                      )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        state.notifications[index].user_sender
                                                .firstname +
                                            ' ' +
                                            state.notifications[index]
                                                .user_sender.lastname,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Text('You have a new review '),
                                ],
                              ),
                            );
                          })),
                        ),
                      ),
                    )
                  else if (state is NotificationsLoadingState)
                    Container(
                      width: context.width,
                      height: context.height,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    Container(
                      width: context.width,
                      height: context.height,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
