import 'dart:convert';

import 'package:delivery/shared/models/UserResponse.dart';
import 'package:delivery/shared/models/messages.dart';
import 'package:delivery/shared/models/user.dart';

class Inbox {
  final int id;
  final UserResponse user;
  final UserResponse connectedUser;
  // final List<Messages> messages;
  final String lastMessage;

  Inbox(
      {this.id,
      this.user,
      this.connectedUser,
      // this.messages,
      this.lastMessage});

  factory Inbox.fromJSON(Map<String, dynamic> jsonMap) {
    return Inbox(
      id: jsonMap["id"],
      user: UserResponse.fromJSON(jsonMap["user"]),
      connectedUser: UserResponse.fromJSON(jsonMap["connectedUser"]),
      // messages:
      // //  jsonMap["messages"],
      // (jsonMap["messages"] as List)
      //     .map((i)  {Messages.fromJSON(i);})
      //     .toList(),
      lastMessage: jsonMap["lastMessage"],
    );
  }
}
