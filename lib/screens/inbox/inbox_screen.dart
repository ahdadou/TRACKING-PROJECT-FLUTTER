import 'package:delivery/screens/inbox/message_screen.dart';
import 'package:delivery/screens/root/root_app.dart';
import 'package:delivery/services/blocs/inbox/inbox_bloc.dart';
import 'package:delivery/services/repositories/chatRepository.dart';
import 'package:delivery/shared/utils/bottom_navigation_bar_json.dart';
import 'package:delivery/shared/utils/size_config.dart';
import 'package:delivery/services/repositories/LoginRepository.dart';
import 'package:delivery/shared/fakeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';



class InboxPage extends StatefulWidget {
  static String routeName = "/inbox";
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<InboxPage> {
  // @override
  // bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    newMessages$.add(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: BlocProvider(
        create: (context) => InboxBloc()..add(FetchInbox()),
        child: getInboxBody(context),
      ),
    );
  }

  getInboxBody(BuildContext context) {
    return BlocBuilder<InboxBloc, InboxState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                "MESSAGES",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            if (state is FetchDataLoading)
              Center(
                child: CircularProgressIndicator(),
              )
            else if (state is FetchInboxSuccess)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                        state.inbox.length,
                        (index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MessagesPage(
                                              userResponse: state
                                                  .inbox[index].connectedUser,
                                              inboxId: state.inbox[index].id,
                                            )));
                              },
                              child: Container(
                                width: context.width,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade200))),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: Image.network(
                                        state.inbox[index].connectedUser.image,
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.inbox[index].connectedUser
                                                    .firstname +
                                                ' ' +
                                                state.inbox[index].connectedUser
                                                    .lastname,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(

                                            state.inbox[index].lastMessage.length>15?state.inbox[index].lastMessage.substring(1,15)+"...":state.inbox[index].lastMessage,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                  ),
                ),
              )
            else
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }

  getAppbar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
              Container(
                child: SvgPicture.asset(
                  notification['active'],
                  width: 25,
                  height: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
