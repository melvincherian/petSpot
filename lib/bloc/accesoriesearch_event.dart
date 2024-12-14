part of 'accesoriesearch_bloc.dart';

@immutable
sealed class AccesoriesearchEvent {}

class SearchAccessories extends AccesoriesearchEvent{
  final String query;

  SearchAccessories({required this.query});
}

class FilterAccessories extends AccesoriesearchEvent{
  final String filter;

  FilterAccessories({required this.filter});
}

class SortAccessories extends AccesoriesearchEvent{
  final bool ascending;

  SortAccessories({required this.ascending});
}

class FetchAccessories extends AccesoriesearchEvent{
  final String categoryid;

  FetchAccessories({required this.categoryid});
}