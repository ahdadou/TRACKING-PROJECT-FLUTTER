import 'package:delivery/shared/models/user.dart';

class Inbox {
  final int id;
  final User user;
  final User connectedUser;
  final String msg;
  final String lastMessage;

  Inbox({this.id, this.user, this.connectedUser, this.msg, this.lastMessage});
}
