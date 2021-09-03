class MessageRequest {
  final String sender_email;
  final String receiver_email;
  final String message;

  MessageRequest({this.sender_email, this.receiver_email, this.message});

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["sender_email"] = sender_email;
    map["receiver_email"] = receiver_email;
    map["message"] = message;
    return map;
  }
}
