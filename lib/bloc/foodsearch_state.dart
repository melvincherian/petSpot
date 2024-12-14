part of 'foodsearch_bloc.dart';

@immutable
sealed class FoodsearchState {}

final class FoodsearchInitial extends FoodsearchState {}

class FoodLoading extends FoodsearchState{}

class FoodLoaded extends FoodsearchState{

final List<FoodProductModel>foods;

FoodLoaded( this.foods);

}

class FoodError extends FoodsearchState{
  final String error;
  FoodError(this.error);
}

class FoodSuccess extends FoodsearchState{
  final String message;

  FoodSuccess(this.message);
}


