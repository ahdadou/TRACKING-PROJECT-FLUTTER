class TrackingRequest {
  String userEmail;
  double latitude;
  double longitude;
  bool active;
  String uuid;

  TrackingRequest(
      {this.userEmail, this.latitude, this.longitude, this.active, this.uuid});


    Map toMap() {
    var map = new Map<String, dynamic>();
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["active"] = active;
    map["uuid"] = uuid;
    map["userEmail"] = userEmail;
    return map;
  }
}
