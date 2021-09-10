import 'package:delivery/shared/models/UserResponse.dart';
import 'package:intl/intl.dart';

class Notifications {
  int id;

  UserResponse user_sender;


  DateTime createAt;

  Notifications( {this.createAt,this.id, this.user_sender, });


  factory Notifications.fromJSON(Map<String, dynamic> jsonMap) {
    return Notifications(
      id:jsonMap["id"],
      user_sender:UserResponse.fromJSON(jsonMap["user_sender"]),
      createAt:DateTime.parse(jsonMap["createAt"]),
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["user_sender"] = user_sender;
    map["createAt"] = createAt;
  
    return map;
  }


 
}
 String formatDateTime(DateTime date){
    return DateFormat('yyyy-MM-dd').format(date);
}