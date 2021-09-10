import 'dart:convert';
import 'dart:io';

import 'package:delivery/services/apis.dart';
import 'package:delivery/services/repositories/LoginRepository.dart';
import 'package:delivery/shared/models/inbox.dart';
import 'package:delivery/shared/models/messageRequest.dart';
import 'package:delivery/shared/models/messages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:http/http.dart' as http;


var messages$ = new BehaviorSubject<List<Messages>>();
var newMessages$ = new BehaviorSubject<bool>();


//get Inbox By User Email
Future<List<Inbox>> getInbox() async {
  print('-------------------getInbox-------------');
  final String url = API_ROOT + "inbox/" + tokenDto.value.email;
  final client = new http.Client();
  final jwt = await getAccessToken();
  final response = await client.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
    },
  );
  List<Inbox> listInbox;
  print("response  :" + response.statusCode.toString());
  if (response.statusCode == 200) {
    print(response.body);
    print('---------------- getInbox ----------');
    var inbox = (json.decode(response.body) as List)
        .map((e) => Inbox.fromJSON(e))
        .toList();
    listInbox = inbox;
    return inbox;
  }

  return listInbox;
}

//   //get Messages By Inbox

Future<List<Messages>> getMessagesByInboxId(int id) async {
  print('-------------------getInbox-------------');
  final String url = API_ROOT + "inbox/messages?id=" + id.toString();
  final client = new http.Client();
  final jwt = await getAccessToken();
  final response = await client.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
    },
  );
  List<Messages> listMessages;
  print("response  :" + response.statusCode.toString());
  if (response.statusCode == 200) {
    print(response.body);
    print('---------------- getMessagesByInboxId ----------');
    var messages = (json.decode(response.body) as List)
        .map((e) => Messages.fromJSON(e))
        .toList();
    // messages$.sink.add(messages);
    listMessages = messages;
    return messages;
  }

  return listMessages;
}


//   //get InboxId 

Future<int> getInboxId(String receiver) async {
  print('-------------------getInboxId-------------');
  final String url = API_ROOT + "inbox/inboxId?sender=" + tokenDto.value.email+'&receiver='+receiver;
  final client = new http.Client();
  final jwt = await getAccessToken();
  final response = await client.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
    },
  );
  int id;
  print("response  :" + response.statusCode.toString());
  if (response.statusCode == 200) {
    print(response.body);
    print('---------------- getMessagesByInboxId ----------');
    var res = response.body;
    id = int.parse(res);
    return id;
  }
  return id;
}


//Send Msg
Future<Messages> sendMessages({String receiver_email, String msg}) async {
  MessageRequest messageRequest = new MessageRequest(
      message: msg,
      sender_email: tokenDto.value.email,
      receiver_email: receiver_email);
  final String url = API_ROOT + "inbox/add";
  final client = new http.Client();
  final jwt = await getAccessToken();
  final response = await client.post(Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
      body: json.encode(messageRequest.toMap()));
  var _message;
  print("response  :" + response.statusCode.toString());
  if (response.statusCode == 200) {
    print('---------------- sendMessages ----------');
    var message = Messages.fromJSON(json.decode(response.body));
    _message = message;
    return message;
  }

  return _message;
}

StompClient chatStompClient = StompClient(
  config: StompConfig(
    // url: "ws://34.125.143.57/flutter",
    url: "ws://192.168.1.106:9004/flutter",
    onConnect: onConnected,
    beforeConnect: () async {
      print('waiting to connect...');
      await Future.delayed(Duration(milliseconds: 200));
      print('connecting...');
    },
    onWebSocketError: (dynamic error) =>
        print('------------ => ' + error.toString()),
    stompConnectHeaders: {'Authorization': 'Bearer ' + tokenDto.value.value},
    webSocketConnectHeaders: {
      'Authorization': 'Bearer ' + tokenDto.value.value
    },
  ),
);

void onConnected(StompFrame frame) {
  chatStompClient.subscribe(
    destination: '/user/' + tokenDto.value.email + '/queue/chat',
    callback: (frame) {
      // List<String> result = json.decode(frame.body);
      var message = Messages.fromJSON(json.decode(frame.body));
      List<Messages> messageslist=[];
      if(messages$.hasValue)
      messageslist=messages$.value;

      messageslist.add(message);
      messages$.sink.add(messageslist);
      newMessages$.sink.add(true);
    },
  );
}
