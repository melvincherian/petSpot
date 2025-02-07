// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_project/Firebase/ratings_repo.dart';
import 'package:second_project/Firebase/user_authentication.dart';
import 'package:second_project/models/review_rating_model.dart';

part 'ratings_event.dart';
part 'ratings_state.dart';

class RatingsBloc extends Bloc<RatingsEvent, RatingsState> {
  final RatingsRepo ratingsRepo;
  final AuthRepository repository;
  // final List<ReviewRatingModel> _reviews = [];

  RatingsBloc({required this.ratingsRepo, required this.repository})
      : super(RatingsInitial()) {
    on<AddreviewEvent>((event, emit) async {
      try {
        final currentUser = repository.currentUser;
        if (currentUser == null) {
          emit(RatingsError('User not logged in'));
          return;
        }

        final userReview =
            event.review.copyWith(userReference: currentUser.uid);

        await ratingsRepo.addReview(userReview.userReference,userReview);
        emit(RatingsSuccess('Review added successfully'));
      } catch (e) {
        emit(RatingsError('Failed to add review: $e'));
      }
    });
  }
}
