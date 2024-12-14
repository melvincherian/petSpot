part of 'breedsearch_bloc.dart';

@immutable
sealed class BreedsearchState {}

final class BreedsearchInitial extends BreedsearchState {}

class BreedLoading extends BreedsearchState{}

class BreedLoaded extends BreedsearchState{
  final List<BreedModel>breeds;
  BreedLoaded(this.breeds);
}

class BreedError extends BreedsearchState{
  final String error;
  BreedError(this.error);
}

class BreedSuccess extends BreedsearchState{
  final String message;

  BreedSuccess(this.message);
}

//
