class UserRequestDTO {
  String firstname;
  String lastname;
  String email;
  String password;
  DateTime birthday;
  String phone;
  bool isToBeAdmin;
  bool man;
  String description;
  String image;
  String cityName;
  bool delivery;
  String country;


  UserRequestDTO(
      {this.firstname,
      this.lastname,
      this.email,
      this.country,
      this.password,
      this.birthday,
      this.phone,
      this.isToBeAdmin,
      this.man,
      this.description,
      this.image,
      this.cityName,
      this.delivery});

   

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["firstname"] = firstname;
    map["lastname"] = lastname;
    map["email"] = email;
    map["country"] = country;
    map["password"] = password;
    map["birthday"] = birthday;
    map["phone"] = phone;
    map["isToBeAdmin"] = isToBeAdmin;
    map["man"] = man;
    map["description"] = description;
    map["image"] = image;
    map["cityName"] = cityName;
    map["delivery"] = delivery;
    return map;
  }
}
