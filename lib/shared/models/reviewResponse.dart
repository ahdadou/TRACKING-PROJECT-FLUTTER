import 'package:delivery/shared/models/UserResponse.dart';
import 'package:intl/intl.dart';

class ReviewResponse {
  int ID;

  UserResponse user_sender;

  int rating;

  String body;
  DateTime createAt;

  ReviewResponse( {this.createAt,this.ID, this.user_sender, this.rating, this.body});


  factory ReviewResponse.fromJSON(Map<String, dynamic> jsonMap) {
    return ReviewResponse(
      ID:jsonMap["ID"],
      user_sender:UserResponse.fromJSON(jsonMap["user_sender"]),
      rating:jsonMap["rating"],
      body:jsonMap["body"],
      createAt:DateTime.parse(jsonMap["createAt"]),
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["ID"] = ID;
    map["user_sender"] = user_sender;
    map["rating"] = rating;
    map["body"] = body;
    map["createAt"] = createAt;
  
    return map;
  }


 
}
 String formatDateTime(DateTime date){
    return DateFormat('yyyy-MM-dd').format(date);

  }