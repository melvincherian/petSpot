part of 'petfood_bloc.dart';

@immutable
sealed class PetfoodState {}

final class PetfoodInitial extends PetfoodState {}

final class PetfoodLoading extends PetfoodState {}

final class PetfoodLoaded extends PetfoodState {
  final List<FoodProductModel> foodProducts;

  PetfoodLoaded(this.foodProducts);
}


final class PetfoodError extends PetfoodState {
  final String error;

  PetfoodError(this.error);
}

final class PetfoodSuccess extends PetfoodState {
  final String message;

  PetfoodSuccess(this.message);
}