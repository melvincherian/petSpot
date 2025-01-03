// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:second_project/models/food_model.dart';

part 'foodsearch_event.dart';
part 'foodsearch_state.dart';

class FoodsearchBloc extends Bloc<FoodsearchEvent, FoodsearchState> {

final List<FoodProductModel>_allFoods=[];

  FoodsearchBloc() : super(FoodsearchInitial()) {
    on<FetchFoods>((event, emit)async {
      emit(FoodLoading());
      try{
        final snapshot=await FirebaseFirestore.instance.collection('foodproducts')
        .where('categoryId',isEqualTo: event.categoryId).get();
        _allFoods.clear();
        _allFoods.addAll(snapshot.docs.map((doc){
           return FoodProductModel.fromJson(doc.data(), doc.id);
        }).toList());
      }catch(e){
        emit(FoodError(e.toString()));
      }
    });

    on<SearchFoods>((event, emit) {
       final searhfoods=_allFoods.where((food)=>food.foodname.toLowerCase().contains(event.query.toLowerCase())).toList();
       emit(FoodLoaded(searhfoods));
    },);


on<FilterFoods>((event, emit) {
  if (event.filter.isEmpty) {
    emit(FoodLoaded(List.from(_allFoods)));
    return;
  }
  final filterPrice = double.tryParse(event.filter);
  if (filterPrice == null) {
    
    emit(FoodLoaded([])); 
    return;
  }

  final filteredFoods = _allFoods.where((foods) {
    return foods.price == filterPrice; // Compare as a numeric type
  }).toList();

  emit(FoodLoaded(filteredFoods));
});

// on<FilterFoodsByPriceRange>((event, emit) async {
//   emit(FoodLoading());
//   try {
//     final filteredFoods = _allFoods.where((food) {
//       return food.price >= event.minPrice && food.price <= event.maxPrice;
//     }).toList();

//     emit(FoodLoaded( filteredFoods));
//   } catch (e) {
//     emit(FoodError( e.toString()));
//   }
// });





    on<SortFoods>((event, emit) {
      final sortedfoods=List<FoodProductModel>.from(_allFoods)..sort((a,b)=>event.ascending?a.price.compareTo(b.price)
      :b.price.compareTo(b.price)
      );
      emit(FoodLoaded(sortedfoods));
    },);
  }
}
