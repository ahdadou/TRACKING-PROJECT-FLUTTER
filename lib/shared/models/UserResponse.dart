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
  int ratingAverage;
  bool compteVerifie;
  DateTime birthday;
  String phone;
int reviewCount;
  UserResponse(
      {
        this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.description,
      this.image,
      this.ratingAverage,
      this.compteVerifie,
      this.birthday,
      this.city,
      this.phone,
      this.reviewCount
      });


  factory UserResponse.fromJSON(Map<String, dynamic> jsonMap) {
    return UserResponse(
      // id:jsonMap["id"],
      firstname:jsonMap["firstname"],
      lastname:jsonMap["lastname"],
      email:jsonMap["email"],
      description:jsonMap["description"],
      image:jsonMap["image"],
      ratingAverage:jsonMap["ratingAverage"],
      compteVerifie:jsonMap["compteVerifie"],
      birthday:jsonMap["birthday"],
      city:jsonMap["city"],
      phone:jsonMap["phone"],
      reviewCount:jsonMap["reviewCount"],
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
    map["ratingAverage"] = ratingAverage;
    map["compteVerifie"] = compteVerifie;
    map["birthday"] = birthday;
    map["city"] = city;
    map["phone"] = phone;
    map["reviewCount"] = reviewCount;
    return map;
  }

    
}
