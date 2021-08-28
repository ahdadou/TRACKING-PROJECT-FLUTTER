class TokenDto {
  String value;
  String email;
  String firstname;
  String lastname;
  String image;

  // used for indicate if client logged in or not
  bool auth;

  TokenDto({this.value, this.email, this.firstname, this.lastname, this.image});

  TokenDto.fromJSON(Map<String, dynamic> jsonMap) {
    value = jsonMap["value"];
    email = jsonMap["email"];
    firstname = jsonMap["firstname"];
    lastname = jsonMap["lastname"];
    image = jsonMap["image"];
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["value"] = value;
    map["email"] = email;
    map["firstname"] = firstname;
    map["lastname"] = lastname;
    map["image"] = image;
  }

  //  bool profileCompleted() {
  //   return address != null && address != '' && phone != null && phone != '';
  // }
}
