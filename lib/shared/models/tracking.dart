class Tracking {
  double latitude;
  double longitude;
  bool active;
  String uuid;

  Tracking({this.latitude, this.longitude, this.active, this.uuid});

  factory Tracking.fromJSON(Map<String, dynamic> jsonMap) {
    return Tracking(
      // id:jsonMap["id"],
      latitude: jsonMap["latitude"],
      longitude: jsonMap["longitude"],
      active: jsonMap["active"],
      uuid: jsonMap["uuid"],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["active"] = active;
    map["uuid"] = uuid;
    return map;
  }
}
