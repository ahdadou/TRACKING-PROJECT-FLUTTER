import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:delivery/services/apis.dart';
import 'package:delivery/shared/models/TokenDto.dart';
import 'package:delivery/shared/models/user.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// User user;
ValueNotifier<TokenDto> tokenDto = new ValueNotifier(TokenDto());

Future<TokenDto> googleLogin(String googleId) async {
  final String url = API_ROOT + "oauth/google";
  final client = new http.Client();

  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode({'value': googleId}),
  );

  print("response  :" + response.statusCode.toString());
  if (response.statusCode == 200) {
    TokenDto _tokenDto = TokenDto.fromJSON(json.decode(response.body));
    String jwt = _tokenDto.value;
    setAccessToken(jwt);
    setTokenDto(response.body);
    print("--------------------From Login------=> :" + _tokenDto.toString());
    // currentUser = await getUsreData(user.accessToken);
  }
  return tokenDto.value;
}

void setAccessToken(jsonString) async {
  if (jsonString != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', jsonString);
  }
}

void setCurrentUser(jsonString) async {
  if (json.decode(jsonString) != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', json.encode(json.decode(jsonString)));
  }
}

Future<TokenDto> getTokenDto() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (tokenDto.value.auth == null && prefs.containsKey('token_dto')) {
    tokenDto.value = TokenDto.fromJSON(await prefs.get('token_dto'));
    tokenDto.value.auth = true;
  } else {
    tokenDto.value.auth = false;
  }
  tokenDto.notifyListeners();
  return tokenDto.value;
}

void setTokenDto(jsonString) async {
  try {
    if (json.decode(jsonString)['data'] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'token_dto', json.encode(json.decode(jsonString)['data']));
    }
  } catch (e) {
    print(e.toString());
    throw new Exception(e);
  }
}

@override
Future<bool> isSignedIn() async {
  TokenDto currentuser = await getTokenDto();
  return currentuser.auth;
}




// Future<User> getUsreData(String jwt) async {
//   User user = User();
//   print('getuserdata function');
//   print(jwt);
//   final String url = "http://192.168.1.103:8008/api/user/getinfo";
//   final client = new http.Client();
//   final response = await client.get(
//     url,
//     headers: {'authorization': 'Bearer ' + jwt},
//   );
//   if (response.statusCode == 200) {
//     print('getuserdata function 200');
//     user = User.fromJSON(json.decode(response.body));
//     setCurrentUser(response.body);
//   }

//   return user;
// }