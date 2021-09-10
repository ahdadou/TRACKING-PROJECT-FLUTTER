



import 'dart:convert';
import 'dart:io';

import 'package:delivery/services/apis.dart';
import 'package:delivery/services/repositories/LoginRepository.dart';
import 'package:delivery/shared/models/reviewResponse.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';


import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

var newReview$ = new BehaviorSubject<bool>();


Future<List<ReviewResponse>> getReviews(String email) async {
  print('-------------------get Review-------------');
  final String url = API_ROOT + "review/email?email=" +email;
  final client = new http.Client();
  final jwt = await getAccessToken();
  final response = await client.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
    },
  );
  List<ReviewResponse> reviews;
  print("response  :" + response.statusCode.toString());
  if (response.statusCode == 200) {
    print(response.body);
    print('---------------- Review ----------');
    var res = (json.decode(response.body) as List)
        .map((e) => ReviewResponse.fromJSON(e))
        .toList();
    reviews = res;
    return res;
  }

  return reviews;
}



StompClient reviewStompClient = StompClient(
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
  reviewStompClient.subscribe(
    destination: '/user/' + tokenDto.value.email + '/queue/review',
    callback: (frame) {
      newReview$.sink.add(true);
    },
  );
}