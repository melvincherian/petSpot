// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:second_project/models/category_models.dart';

part 'searchcategory_event.dart';
part 'searchcategory_state.dart';

class SearchcategoryBloc extends Bloc<SearchcategoryEvent, SearchcategoryState> {
  List<CategoryModel> _allCategories = [];

  SearchcategoryBloc() : super(SearchcategoryInitial()) {
    on<LoadCategoriesevent>(_onLoadCategories); 
    on<searchcategoriesevent>(_onSearchCategories); 
  }

  Future<void> _onLoadCategories(
      LoadCategoriesevent event, Emitter<SearchcategoryState> emit) async {
    emit(Searchcategoryloading());
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      _allCategories = querySnapshot.docs
          .map((doc) => CategoryModel.fromSnapshot(doc))
          .toList();
      emit(Searchcategoryloaded(_allCategories));
    } catch (e) {
      emit(Searchcategoryerror('Error loading categories: $e'));
    }
  }

  void _onSearchCategories(
      searchcategoriesevent event, Emitter<SearchcategoryState> emit) {
    final query = event.query.toLowerCase();
    final filteredCategories = _allCategories
        .where((category) =>
            category.name.toLowerCase().contains(query) ||
            category.description.toLowerCase().contains(query))
        .toList();
    emit(Searchcategoryloaded(filteredCategories));
  }
}
