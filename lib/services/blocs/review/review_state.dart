part of 'review_bloc.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();
  
  @override
  List<Object> get props => [];
}

class ReviewInitial extends ReviewState {}



class FetchDataLoading extends ReviewState {
   @override
  List<Object> get props => [];
}


class FetchReviewsSuccess extends ReviewState {
  final List<ReviewResponse> reviews;

  FetchReviewsSuccess({this.reviews});
   @override
  List<Object> get props => [];
}


class FetchDataFailler extends ReviewState {
   @override
  List<Object> get props => [];
}