part of 'ratings_bloc.dart';

@immutable
sealed class RatingsEvent {}

class AddreviewEvent extends RatingsEvent {
  final String productReference;
  final ReviewItems review;
  AddreviewEvent({required this.review, required this.productReference});
}

class FetchReviews extends RatingsEvent {}

class FetchReviewById extends RatingsEvent {
  final String id;
  FetchReviewById(this.id);
}

class DeleteReviews extends RatingsEvent {
  final String id;

  DeleteReviews(this.id);
}
