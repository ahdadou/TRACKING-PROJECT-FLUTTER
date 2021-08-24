import 'package:delivery/shared/models/user.dart';

class Messages {
  final int id;
  final User user_sender;
  final String msg;
  final DateTime createAt;

  Messages({this.id, this.user_sender, this.msg, this.createAt});
}
