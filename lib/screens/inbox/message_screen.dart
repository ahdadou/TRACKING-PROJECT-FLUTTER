import 'package:delivery/shared/fakeData.dart';
import 'package:flutter/material.dart';
import 'package:delivery/shared/utils/size_config.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                      chatDetails.length,
                      (index) => ChatBubble(
                            clipper: chatDetails[index]["isMe"]
                                ? ChatBubbleClipper1(
                                    type: BubbleType.sendBubble)
                                : ChatBubbleClipper1(
                                    type: BubbleType.receiverBubble),
                            alignment: chatDetails[index]["isMe"]
                                ? Alignment.topRight
                                : null,
                            margin: EdgeInsets.only(top: 20),
                            backGroundColor: chatDetails[index]["isMe"]
                                ? Colors.blue
                                : Color(0xffE7E7ED),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Text(
                                chatDetails[index]["message"],
                                style: TextStyle(
                                    color: chatDetails[index]["isMe"]
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          )),
                ),
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
                      decoration: InputDecoration(
                          hintText: "New message...",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: InputBorder.none),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: IconButton(
                      onPressed: () {},
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
      ),
    );
  }

  getAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(40),
      child: SafeArea(
        child: Container(
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
              ClipOval(
                child: Image.network(
                  users[0].image,
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                users[0].firstName,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  getBody() {
    return Column(
      children: [
        // Expanded(
        //     flex: 1,
        //     child: SingleChildScrollView(
        //       child: Container(),
        //     )),
        Container(
          width: 100,
          height: 100,
          child: Row(
            children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term'),
              ),
              Icon(
                Icons.send,
                color: Colors.blue[600],
              )
            ],
          ),
        )
      ],
    );
  }
}
