import 'package:delivery/shared/models/user.dart';

class Review {
  final int id;
  final User user_sender;
  final double rating;
  final String body;
  final DateTime createAt;

  Review({this.id, this.user_sender, this.rating, this.body, this.createAt});




  
}
