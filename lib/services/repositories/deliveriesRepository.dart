import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:delivery/services/apis.dart';
import 'package:delivery/services/repositories/LoginRepository.dart';
import 'package:delivery/shared/models/UserResponse.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// Future<TokenDto> getAllDeliveries(String googleId) async {
//   final String url = API_ROOT + "oauth/google";
//   final client = new http.Client();

//   final response = await client.post(
//     Uri.parse(url),
//     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//     body: json.encode({'value': googleId}),
//   );

//   print("response  :" + response.statusCode.toString());
//   if (response.statusCode == 200) {
//     TokenDto _tokenDto = TokenDto.fromJSON(json.decode(response.body));
//     String jwt = _tokenDto.value;
//     setAccessToken(jwt);
//     setTokenDto(response.body);
//   }
//   return tokenDto.value;
// }

Future<List<UserResponse>> getDeliveriesByCountry() async {
  final String url = API_ROOT + "deliveries";
  final client = new http.Client();
  final jwt = await getAccessToken();
  final response = await client.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + jwt
    },
  );
  List<UserResponse> usersResponse = [];
  print("response  :" + response.statusCode.toString());
  if (response.statusCode == 200) {
    var usersResponseJson = (json.decode(response.body) as List)
        .map((e) => UserResponse.fromJSON(e))
        .toList();
    usersResponse = usersResponseJson;
    return usersResponseJson;
  }

  return usersResponse;
}


Future<List<UserResponse>> getAllUsers() async {
  final String url = API_ROOT + "users/all/"+tokenDto.value.email;
  final client = new http.Client();
  final jwt = await getAccessToken();
  final response = await client.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + jwt
    },
  );
  List<UserResponse> usersResponse = [];
  print("response  :" + response.statusCode.toString());
  if (response.statusCode == 200) {
    var usersResponseJson = (json.decode(response.body) as List)
        .map((e) => UserResponse.fromJSON(e))
        .toList();
    usersResponse = usersResponseJson;
    return usersResponseJson;
  }

  return usersResponse;
}


Future<List<UserResponse>> getDeliveriesByCityOrEmail(String param) async {
  final String url = API_ROOT + "deliveries/filter?param="+param;
  final client = new http.Client();
  final jwt = await getAccessToken();
  final response = await client.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + jwt
    },
  );
  List<UserResponse> usersResponse = [];
  print("response  :" + response.statusCode.toString());
  if (response.statusCode == 200) {
    var usersResponseJson = (json.decode(response.body) as List)
        .map((e) => UserResponse.fromJSON(e))
        .toList();
    print(response.body);
    usersResponse = usersResponseJson;
    return usersResponseJson;
  }

  return usersResponse;
}

Future<List<UserResponse>> getAllUsersByCityOrEmail(String param) async {
  final String url = API_ROOT + "users/filter?param="+param+"&email="+tokenDto.value.email;
  final client = new http.Client();
  final jwt = await getAccessToken();
  final response = await client.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + jwt
    },
  );
  List<UserResponse> usersResponse = [];
  print("response  :" + response.statusCode.toString());
  if (response.statusCode == 200) {
    var usersResponseJson = (json.decode(response.body) as List)
        .map((e) => UserResponse.fromJSON(e))
        .toList();
    usersResponse = usersResponseJson;
    return usersResponseJson;
  }

  return usersResponse;
}


getDeliveriesByCity() {}

getDeliveryByFullName() {}
