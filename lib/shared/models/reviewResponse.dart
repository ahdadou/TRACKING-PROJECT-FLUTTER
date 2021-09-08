import 'package:delivery/shared/models/UserResponse.dart';

class ReviewResponse {
  int ID;

  UserResponse user_sender;

  int rating;

  String body;

  ReviewResponse({this.ID, this.user_sender, this.rating, this.body});


  factory ReviewResponse.fromJSON(Map<String, dynamic> jsonMap) {
    return ReviewResponse(
      ID:jsonMap["ID"],
      user_sender:UserResponse.fromJSON(jsonMap["user_sender"]),
      rating:jsonMap["rating"],
      body:jsonMap["body"],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["ID"] = ID;
    map["user_sender"] = user_sender;
    map["rating"] = rating;
    map["body"] = body;
  
    return map;
  }
}
