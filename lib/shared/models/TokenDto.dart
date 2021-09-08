class TokenDto {
  String value;
  String email;
  String firstname;
  String lastname;
  String image;
   bool newAccount;

  // used for indicate if client logged in or not
  bool auth=false;

  TokenDto( {this.newAccount,this.value, this.email, this.firstname, this.lastname, this.image});

  // TokenDto.fromJSON(Map<String, dynamic> jsonMap) {
  //   value = jsonMap["value"].toString() ?? '';
  //   email = jsonMap["email"].toString() ?? '';
  //   firstname = jsonMap["firstname"].toString() ?? '';
  //   lastname = jsonMap["lastname"].toString() ?? '';
  //   image = jsonMap["image"].toString() ?? '';
  // }

  factory TokenDto.fromJSON(Map<String, dynamic> jsonMap) {
    return TokenDto(
      value: jsonMap["value"].toString() ?? '',
      email: jsonMap["email"].toString() ,
      firstname: jsonMap["firstname"].toString() ?? '',
      lastname: jsonMap["lastname"].toString() ?? '',
      image: jsonMap["image"].toString() ?? '',
      newAccount: jsonMap["newAccount"] ,
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["value"] = value;
    map["email"] = email;
    map["firstname"] = firstname;
    map["lastname"] = lastname;
    map["image"] = image;
    map["newAccount"] = newAccount;
    return map;
  }

  //  bool profileCompleted() {
  //   return address != null && address != '' && phone != null && phone != '';
  // }
}
