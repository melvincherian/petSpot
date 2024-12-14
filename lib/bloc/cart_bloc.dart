// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_project/models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartModel>_cart=[];
  CartBloc() : super(CartInitial()) {
    on<AddToCart>((event, emit) {
      _cart.add(event.item);
      emit(CartLoaded(List.from(_cart)));
    });

    on<RemoveCart>((event, emit) {
       _cart.removeWhere((item)=>item.id==event.itemId);
       emit(CartLoaded(List.from(_cart)));
    },);

    on<FetchCartitems>((event, emit) {
       emit(CartLoaded(List.from(_cart)));
    },);
  }
}
