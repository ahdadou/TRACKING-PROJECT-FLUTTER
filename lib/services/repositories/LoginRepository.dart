import 'dart:convert';
import 'dart:io';
import 'package:delivery/services/apis.dart';
import 'package:delivery/shared/models/TokenDto.dart';
import 'package:delivery/shared/models/userRequestDto.dart';
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
    tokenDto.value = TokenDto.fromJSON(json.decode(response.body));
    setTokenDto(response.body);
    setEmail(tokenDto.value.email);
    setAccessToken(tokenDto.value.value);
  }
  return tokenDto.value;
}

Future<void> logout() async {
  tokenDto.value = new TokenDto();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token_dto');
}

Future<bool> updateDataUser(UserRequestDTO userRequestDTO) async {
  final String url = API_ROOT + "oauth/update";
  final client = new http.Client();
  userRequestDTO.email = await getEmail();
  print(await getEmail());
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(userRequestDTO.toMap()),
  );

  print("response  :" + response.statusCode.toString());
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

void setAccessToken(jsonString) async {
  if (jsonString != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', jsonString);
  }
}

Future<String> getAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token');
}

void setEmail(email) async {
  if (email != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }
}

Future<String> getEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String email = prefs.getString('email');
  return email;
}

void setCurrentUser(jsonString) async {
  if (json.decode(jsonString) != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', json.encode(json.decode(jsonString)));
  }
}

Future<TokenDto> getTokenDto() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    if (prefs.containsKey('token_dto')) {
      tokenDto.value =
          TokenDto.fromJSON(json.decode(await prefs.get('token_dto')));
      tokenDto.value.auth = true;
    } else {
      tokenDto.value.auth = false;
    }
    return tokenDto.value;
  } catch (e) {
    print(e);
  }
}

void setTokenDto(jsonString) async {
  try {
    if (json.decode(jsonString) != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token_dto', jsonString);
    }
  } catch (e) {
    print(e.toString());
    throw new Exception(e);
  }
}

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