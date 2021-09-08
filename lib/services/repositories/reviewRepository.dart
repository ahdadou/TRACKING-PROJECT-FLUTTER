



import 'dart:convert';
import 'dart:io';

import 'package:delivery/services/apis.dart';
import 'package:delivery/services/repositories/LoginRepository.dart';
import 'package:delivery/shared/models/reviewResponse.dart';
import 'package:http/http.dart' as http;


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