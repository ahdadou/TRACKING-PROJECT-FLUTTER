import 'package:delivery/services/blocs/inbox/inbox_bloc.dart';
import 'package:delivery/services/repositories/chatRepository.dart';
import 'package:delivery/shared/fakeData.dart';
import 'package:delivery/shared/models/UserResponse.dart';
import 'package:delivery/shared/models/messages.dart';
import 'package:flutter/material.dart';
import 'package:delivery/shared/utils/size_config.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_7.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';

class MessagesPage extends StatefulWidget {
  final int inboxId;
  final UserResponse userResponse;
  const MessagesPage(
      {Key key, this.userResponse, this.inboxId})
      : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  var myController = TextEditingController();
  List<Messages> messages;
  final _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messages$.stream.listen((event) {
      if (this.mounted) 
      setState(() {});
      this.messages = event;  
       Future.delayed(Duration(milliseconds: 30), () {
        if (_controller.hasClients)
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _controller.jumpTo(_controller.position.maxScrollExtent);
        });      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: BlocProvider(
        create: (context) =>
            InboxBloc()..add(FetchChat(inboxId: widget.inboxId)),
        child: getBody(context),
      ),
    );
  }

  Widget getBody(BuildContext context) {
    return BlocBuilder<InboxBloc, InboxState>(
      builder: (context, state) {
        if (state is FetchDataLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        else if (state is FetchChatSuccess)
          return Column(
            children: [
              if (messages != null)
                Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: ListView.builder(
                          controller: _controller,
                          itemCount: messages.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          // physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) => ChatBubble(
                                clipper: messages[index].user_sender.email !=
                                        widget.userResponse.email
                                    ? ChatBubbleClipper8(
                                        type: BubbleType.sendBubble)
                                    : ChatBubbleClipper8(
                                        type: BubbleType.receiverBubble),
                                alignment: messages[index].user_sender.email !=
                                        widget.userResponse.email
                                    ? Alignment.topRight
                                    : null,
                                margin: EdgeInsets.only(top: 20),
                                backGroundColor:
                                    messages[index].user_sender.email !=
                                            widget.userResponse.email
                                        ? Colors.blue
                                        : Color(0xffE7E7ED),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.7,
                                  ),
                                  child: Text(
                                    messages[index].msg,
                                    style: TextStyle(
                                        color:
                                            messages[index].user_sender.email !=
                                                    widget.userResponse.email
                                                ? Colors.white
                                                : Colors.black),
                                  ),
                                ),
                              )),
                    )),
              Container(
                // width: context.width,
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35.0),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 2,
                        color: Colors.grey[300])
                  ],
                ),
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: new TextField(
                          controller: myController,
                          decoration: InputDecoration(
                              hintText: "New message...",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              border: InputBorder.none),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: IconButton(
                          onPressed: () {
                            // sendMessages(
                            //     receiver_email: widget.userResponse.email,
                            //     msg: myController.text);

                            BlocProvider.of<InboxBloc>(context).add(
                                SendTextMessageEvent(
                                    receiver_email: widget.userResponse.email,
                                    messages: myController.text));

                            myController.clear();
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.blue[600],
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }

  getAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: SafeArea(
        child: Container(
          child: Row(
            children: [
              IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios)),
              ClipOval(
                child: Image.network(
                  widget.userResponse.image ?? users[0].image,
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.userResponse.firstname +
                    ' ' +
                    widget.userResponse.lastname,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // messages$.close();
    print('-----------test');
    super.dispose();
  }
}
