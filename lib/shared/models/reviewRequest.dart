class ReviewRequest {
  final String email_sender;
  final String email_receiver;
  final double rating;
  final String body;
  
  ReviewRequest(
      {this.email_sender, this.email_receiver, this.rating, this.body});
}
