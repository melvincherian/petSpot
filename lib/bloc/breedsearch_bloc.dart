// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:second_project/models/breed_model.dart';

part 'breedsearch_event.dart';
part 'breedsearch_state.dart';

class BreedsearchBloc extends Bloc<BreedsearchEvent, BreedsearchState> {
  final List<BreedModel> _allBreeds = [];

  BreedsearchBloc() : super(BreedsearchInitial()) {
    on<FetchBreedsEvent>((event, emit) async {
      emit(BreedLoading());
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('breed')
            .where('category', isEqualTo: event.categoryid)
            .get();

        _allBreeds.clear();
        _allBreeds.addAll(snapshot.docs.map((doc) {
          return BreedModel.fromMap(doc.data(), doc.id);
        }).toList());

        emit(BreedLoaded(List.from(_allBreeds)));
      } catch (e) {
        emit(BreedError(e.toString()));
      }
    });

    on<SerchBreeds>((event, emit) {
      final Filteredbreeds = _allBreeds
          .where((breed) =>
              breed.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(BreedLoaded(Filteredbreeds));
    });

    on<FilterBreeds>((event, emit) {
      if (event.filter.isEmpty) {
        emit(BreedLoaded(List.from(_allBreeds)));
        return;
      }
      final filteredBreeds = _allBreeds.where((breed) {
        return breed.gender.toLowerCase() == event.filter.toLowerCase();
      }).toList();

      emit(BreedLoaded(filteredBreeds));
    });

    on<SortBreeds>((event, emit) {
      final sortBreeds = List<BreedModel>.from(_allBreeds)
        ..sort((a, b) => event.ascending
            ? a.price.compareTo(b.price)
            : b.price.compareTo(b.price));
      emit(BreedLoaded(sortBreeds));
    });
  }
}
