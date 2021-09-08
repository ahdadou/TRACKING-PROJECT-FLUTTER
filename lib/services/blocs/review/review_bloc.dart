import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:delivery/shared/models/reviewResponse.dart';
import 'package:equatable/equatable.dart';
import 'package:delivery/services/repositories/reviewRepository.dart'
    as reviewRepository;
part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewInitial());

  @override
  Stream<ReviewState> mapEventToState(
    ReviewEvent event,
  ) async* {
    // TODO: implement mapEventToState
    try {
      if (event is fetchUserReviews) {
        yield FetchDataLoading();
        var reviews = await reviewRepository.getReviews(event.email);
        if (reviews != null) {
          yield FetchReviewsSuccess(reviews: reviews);
        } else {
          yield FetchDataFailler();
        }
      }
    } catch (e) {}
  }
}
