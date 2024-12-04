part of 'searchcategory_bloc.dart';

@immutable
sealed class SearchcategoryState {}

final class SearchcategoryInitial extends SearchcategoryState {}

class Searchcategoryloading extends SearchcategoryState{}

class Searchcategoryloaded extends SearchcategoryState{
  final List<CategoryModel>categories;

  Searchcategoryloaded(this.categories);

}

class Searchcategoryerror extends SearchcategoryState{
  final String error;

  Searchcategoryerror(this.error);
}

class Searchcategorysuccess extends SearchcategoryState{
  final String message;

  Searchcategorysuccess(this.message);
}
