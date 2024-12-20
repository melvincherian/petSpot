// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_project/Firebase/cart_repository.dart';
import 'package:second_project/models/cart_model.dart';

part 'cartmanagement_event.dart';
part 'cartmanagement_state.dart';

class CartmanagementBloc extends Bloc<CartmanagementEvent, CartmanagementState> {

final CartRepository cartRepository;

  CartmanagementBloc({required this.cartRepository}) : super(CartmanagementInitial()) {
    on<FetchcartItems>((event, emit)async {
      emit(CartLoadingmanagement());
      try{
        final cartStream=cartRepository.fetchCartItems();
        await emit.forEach<List<CartModel>>(cartStream, 
        onData: (cartItems)=>CartLoadedmanagement(cartItems),
        onError: (error,StackTrace)=>Cartmanagementerror(error.toString())

        );
      }catch(e){
        emit(Cartmanagementerror('Error fetching cart$e'));
      }
    });

    on<AddCartItems>((event, emit)async {
        try{
          await cartRepository.addToCart(event.cartitem);

        }catch(e){
          emit(Cartmanagementerror('Failed to add cart $e'));
        }
    },);

    on<RemoveCartItem>((event, emit)async {
      try{
          await cartRepository.removeCartItem(event.itemId);
      }catch(e){
        emit(Cartmanagementerror('Failed to remove item from cart$e'));
      }
    },);
  }
}
