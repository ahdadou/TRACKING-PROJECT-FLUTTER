import 'package:delivery/shared/models/UserResponse.dart';

class ReviewResponse {
  int ID;

  UserResponse user_sender;

  int rating;

  String body;

  ReviewResponse({this.ID, this.user_sender, this.rating, this.body});
}
