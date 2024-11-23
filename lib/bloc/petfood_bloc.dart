// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:second_project/models/food_model.dart';

part 'petfood_event.dart';
part 'petfood_state.dart';

class PetfoodBloc extends Bloc<PetfoodEvent, PetfoodState> {
  PetfoodBloc() : super(PetfoodInitial()) {
    on<Fetchfoodproduct>(_onFetchPetfood);
      
    
  }

   Future<void> _onFetchPetfood(
      Fetchfoodproduct event, Emitter<PetfoodState> emit) async {
    emit(PetfoodLoading());
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('foodproducts').get();

      final foodProducts = querySnapshot.docs.map((doc) {
        return FoodProductModel.fromSnapshot(doc);
      }).toList();

      emit(PetfoodLoaded(foodProducts));
    } catch (e) {
      emit(PetfoodError('Failed to fetch food products: ${e.toString()}'));
    }
  }
}
