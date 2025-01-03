part of 'breedsearch_bloc.dart';

@immutable
sealed class BreedsearchEvent {}


class SerchBreeds extends BreedsearchEvent{

  final String query;
  SerchBreeds({required this.query});

}

class FilterBreeds extends BreedsearchEvent{
  final String filter;

  FilterBreeds({required this.filter});
}


class SortBreeds extends BreedsearchEvent{
  final bool ascending;

  SortBreeds({required this.ascending});
}

class FetchBreedsEvent extends BreedsearchEvent {
  final String categoryid;

  FetchBreedsEvent({required this.categoryid});
}


