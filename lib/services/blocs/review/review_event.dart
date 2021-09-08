part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}


class fetchUserReviews extends ReviewEvent{
  final String email;

  fetchUserReviews({this.email});
}