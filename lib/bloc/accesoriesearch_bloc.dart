// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:second_project/models/accessory_model.dart';

part 'accesoriesearch_event.dart';
part 'accesoriesearch_state.dart';

class AccesoriesearchBloc
    extends Bloc<AccesoriesearchEvent, AccesoriesearchState> {
  final List<ProductAccessoriesModel> _allAccessories = [];

  AccesoriesearchBloc() : super(AccesoriesearchInitial()) {
    on<FetchAccessories>((event, emit) async {
      emit(AccessoryLoading());
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('accessories')
            .where('categoryId', isEqualTo: event.categoryid)
            .get();

        _allAccessories.clear();
        _allAccessories.addAll(snapshot.docs.map((doc) {
          return ProductAccessoriesModel.fromMap(doc.data(), doc.id);
        }).toList());
        emit(AccesoriesLoaded(_allAccessories)); // Emit loaded state here
      } catch (e) {
        emit(AccessoryError(e.toString()));
      }
    });

    on<SearchAccessories>(
      (event, emit) {
        final searchaccessories = _allAccessories
            .where((accessories) => accessories.accesoryname
                .toLowerCase()
                .contains(event.query.toLowerCase()))
            .toList();
        emit(AccesoriesLoaded(searchaccessories));
      },
    );

    on<FilterAccessories>((event, emit) {
      if (event.filter.isEmpty) {
        emit(AccesoriesLoaded(List.from(_allAccessories)));
        return;
      }
      final filteredAccessories = _allAccessories.where((accesory) {
        return accesory.size.toLowerCase() == event.filter.toLowerCase();
      }).toList();

      emit(AccesoriesLoaded(filteredAccessories));
    });

    on<SortAccessories>(
      (event, emit) {
        final sortaccessories =
            List<ProductAccessoriesModel>.from(_allAccessories)
              ..sort((a, b) => event.ascending
                  ? a.price.compareTo(b.price)
                  : b.price.compareTo(b.price));
        emit(AccesoriesLoaded(sortaccessories));
      },
    );
  }
}
