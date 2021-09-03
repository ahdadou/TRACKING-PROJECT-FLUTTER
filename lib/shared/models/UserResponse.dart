import 'package:delivery/shared/models/reviewResponse.dart';

class UserResponse {
  int id;
  String firstname;
  String lastname;
  String email;
  String description;
  String image;
  //  Gender gender;
  String city;
  int avergeRating;
  bool compteVerifie;
  DateTime birthday;
  String phone;
  List<ReviewResponse> reviews = [];

  UserResponse(
      {
        this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.description,
      this.image,
      this.avergeRating,
      this.compteVerifie,
      this.birthday,
      this.city,
      this.phone
      });


  factory UserResponse.fromJSON(Map<String, dynamic> jsonMap) {
    return UserResponse(
      // id:jsonMap["id"],
      firstname:jsonMap["firstname"],
      lastname:jsonMap["lastname"],
      email:jsonMap["email"],
      description:jsonMap["description"],
      image:jsonMap["image"],
      avergeRating:jsonMap["avergeRating"],
      compteVerifie:jsonMap["compteVerifie"],
      birthday:jsonMap["birthday"],
      city:jsonMap["city"],
      phone:jsonMap["phone"],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["firstname"] = firstname;
    map["lastname"] = lastname;
    map["email"] = email;
    map["description"] = description;
    map["image"] = image;
    map["avergeRating"] = avergeRating;
    map["compteVerifie"] = compteVerifie;
    map["birthday"] = birthday;
    map["city"] = city;
    map["phone"] = phone;
    return map;
  }

    
}
