// ignore_for_file: camel_case_types

part of 'searchcategory_bloc.dart';

@immutable
sealed class SearchcategoryEvent {}

class LoadCategoriesevent extends SearchcategoryEvent{}

class searchcategoriesevent extends SearchcategoryEvent{
   final String query;

  searchcategoriesevent(this.query);
}