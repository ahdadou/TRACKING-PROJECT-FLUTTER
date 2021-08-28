import 'dart:convert';
import 'dart:async';
import 'dart:convert' show json;

import 'package:delivery/services/repositories/LoginRepository.dart';
import "package:http/http.dart" as http;
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin {
  GoogleSignInAccount _currentUser;
  String _contactText = '';

  GoogleLogin() {
    print("----------------------from google----------");
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      _currentUser = account;
      // if (_currentUser != null) {
      //   print("----------------------from onCurrentUserChanged---------- => " +
      //       _currentUser.toString());
      //   _handleGetContact(_currentUser);
      // }
    });
    _googleSignIn.signInSilently();
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly',
      // "https://www.googleapis.com/auth//userinfo.profile"
    ],
  );

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      _contactText = "People API gave a ${response.statusCode} "
          "response. Check logs for details.";
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    if (namedContact != null) {
      _contactText = "I see you know $namedContact!";
    } else {
      _contactText = "No contacts to display.";
    }
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  Future<GoogleSignInAccount> handleSignIn() async {
    try {
      await _googleSignIn.signIn().then((result) {
        result.authentication.then((googleKey) {
          print("----------------------from handleSignIn----------");
          print('idToken => ' + googleKey.idToken.toString());
          return result;
        }).catchError((err) {
          print('inner error');
        });
      });
    } catch (error) {
      print(error);
    }
  }

  Future<GoogleSignInAccount> getCurrentUser() async {
    return await _currentUser;
  }

  Future<void> handleSignOut() => _googleSignIn.disconnect();
}
