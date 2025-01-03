part of 'foodsearch_bloc.dart';

@immutable
sealed class FoodsearchEvent {}

class SearchFoods extends FoodsearchEvent{
  final String query;

  SearchFoods({required this.query});
}

class FilterFoods extends FoodsearchEvent{
  final String filter;

  FilterFoods({required this.filter});
}

class SortFoods extends FoodsearchEvent{
  final bool ascending;

  SortFoods({required this.ascending});
}

class FetchFoods extends FoodsearchEvent{
  final String categoryId;

  FetchFoods({required this.categoryId});
}

class FilterFoodsByPriceRange extends FoodsearchEvent {
  final double minPrice;
  final double maxPrice;

  FilterFoodsByPriceRange({required this.minPrice, required this.maxPrice});
}


