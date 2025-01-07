part of 'ratings_bloc.dart';

@immutable
sealed class RatingsState {}

final class RatingsInitial extends RatingsState {}

class RatingsLoading extends RatingsState {}

class RatingsLoaded extends RatingsState {
  final List<ReviewRatingModel> items;

  RatingsLoaded(this.items);
}

class RatingsError extends RatingsState {
  final String error;

  RatingsError(this.error);
}

class RatingsSuccess extends RatingsState {
  final String message;

  RatingsSuccess(this.message);
}
