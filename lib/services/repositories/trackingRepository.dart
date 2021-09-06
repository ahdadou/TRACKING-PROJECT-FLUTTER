import 'dart:convert';
import 'dart:io';

import 'package:delivery/services/apis.dart';
import 'package:delivery/services/repositories/LoginRepository.dart';
import 'package:delivery/shared/models/tracking.dart';
import 'package:delivery/shared/models/trackingRequest.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:http/http.dart' as http;

var tracking$ = new BehaviorSubject<Tracking>();
var otherLocation$ = new BehaviorSubject<Tracking>();

var uuid$ = new BehaviorSubject<String>();

//get Inbox By User Email
Future<Tracking> getTracking({double lan, double lon}) async {
  print('---------------- get Tracking By UUID ----------');
  TrackingRequest trackingRequest = new TrackingRequest();
  trackingRequest.active = true;
  trackingRequest.latitude = lan;
  trackingRequest.longitude = lon;
  trackingRequest.userEmail = await getEmail();

  final String url = API_ROOT + "track";
  final client = new http.Client();
  final jwt = await getAccessToken();
  final response = await client.post(Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
      body: json.encode(trackingRequest.toMap()));
  Tracking tracking;
  print("response  :" + response.statusCode.toString());
  if (response.statusCode == 200) {
    tracking = Tracking.fromJSON(json.decode(response.body));
    tracking$.sink.add(tracking);
    return tracking;
  }

  return tracking;
}

Future<Tracking> updateTrackingLocation({double lan, double lon}) async {
  TrackingRequest trackingRequest = new TrackingRequest();
  trackingRequest.latitude = lan;
  trackingRequest.longitude = lon;
  trackingRequest.uuid=tracking$.value.uuid;
  trackingRequest.userEmail = await getEmail();
  print('---------------- get updateLocation  ----------');
  final String url = API_ROOT + "track/updateLocation";
  final client = new http.Client();
  final jwt = await getAccessToken();
  final response = await client.post(Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
      body: json.encode(trackingRequest.toMap()));
  Tracking tracking;
  print("response  :" + response.statusCode.toString());
  if (response.statusCode == 200) {
    tracking = Tracking.fromJSON(json.decode(response.body));
    tracking$.sink.add(tracking);

    return tracking;
  }
  return tracking;
}

Future<Tracking> updateTrackingUUID() async {

    TrackingRequest trackingRequest = new TrackingRequest();
    trackingRequest.userEmail = await getEmail();


  print('---------------- get updateCode  ----------');
  final String url = API_ROOT + "track/updateCode";
  final client = new http.Client();
  final jwt = await getAccessToken();
  final response = await client.post(Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
      body: json.encode(trackingRequest.toMap()));
  Tracking tracking;
  print("response  :" + response.statusCode.toString());
  if (response.statusCode == 200) {
    print(response.body);
    print('---------------- get updateCode ----------');
    tracking = Tracking.fromJSON(json.decode(response.body));
    tracking$.sink.add(tracking);

    return tracking;
  }
  return tracking;
}

Future<Tracking> getLocationByUUID(String uuid) async {
  print('---------------- get updateCode  ----------');
  final String url = API_ROOT + "track/updateCode/" + uuid;
  final client = new http.Client();
  final jwt = await getAccessToken();
  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
    },
  );
  Tracking tracking;
  print("response  :" + response.statusCode.toString());
  if (response.statusCode == 200) {
    print(response.body);
    print('---------------- getLocationByUUID ----------');
    tracking = Tracking.fromJSON(json.decode(response.body));
    return tracking;
  }
  return tracking;
}

StompClient stompClientTrack = StompClient(
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
  print("----------------fuuuck");
  print(uuid$.value);
  stompClientTrack.subscribe(
    destination: '/user/' + uuid$.value + '/queue/tracking',
    callback: (frame) {
      var tracking = Tracking.fromJSON(json.decode(frame.body));
      otherLocation$.sink.add(tracking);
      print('--------eeeee');
    },
  );
}
