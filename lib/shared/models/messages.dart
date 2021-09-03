import 'package:delivery/shared/models/UserResponse.dart';
import 'package:delivery/shared/models/user.dart';

class Messages {
  final UserResponse user_sender;
  final String msg;
  final String createAt;


  Messages({ this.user_sender, this.msg, this.createAt});


    Map toMap() {
    var map = new Map<String, dynamic>();
    map["user_sender"] = user_sender;
    map["msg"] = msg;
    map["createAt"] = createAt;
    return map;
  }


  
  factory Messages.fromJSON(Map<String, dynamic> jsonMap) {
    return Messages(
      user_sender:UserResponse.fromJSON(jsonMap["user_sender"]),
      msg:jsonMap["msg"],
      createAt:jsonMap["createAt"],

    );
  }
}
