// ignore_for_file: depend_on_referenced_packages, unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_project/Firebase/cart_repository.dart';
import 'package:second_project/Firebase/user_authentication.dart';
import 'package:second_project/models/cart_model.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

   final CartRepository cartRepository;
  final AuthRepository authService;
  final List<CartModel> _cart = [];

  CartBloc({required this.authService,required this.cartRepository}) : super(CartInitial()) {
   
     on<AddToCart>((event, emit) async {
      try {
        final currentUser = authService.currentUser??();
        if (currentUser == null) {
          emit(CartError('User not logged in'));
          return;
        }

        // Update cart model with user reference
        final cartWithUserRef = event.item.copyWith(
          userReference: authService.currentUser?.uid
        );

        await cartRepository.addToCart(cartWithUserRef);
        emit(CartSuccess('Item added to cart'));
      } catch (e) {
        emit(CartError('Failed to add item to cart'));
      }
    });

    on<RemoveCart>((event, emit) {
      _cart.removeWhere((cartModel) => 
        cartModel.items.any((item) => item.productReference == event.itemId)
      );
      emit(CartLoaded(List.from(_cart), totalAmount: _cart.fold(
    0.0,
    (sum, cart) => sum + cart.items.fold(0.0, (sum, item) => sum + item.subtotal),
  ),));
    });

    on<UpdateCartItemQuantity>((event, emit) {
      for (var cartModel in _cart) {
        for (var item in cartModel.items) {
          if (item.productReference == event.itemId) {
            final updatedItem = CartItem(
              productReference: item.productReference,
              price: item.price,
              quantity: event.newQuantity,
              // subtotal: item.price * event.newQuantity
            );
            
            // Replace the old item with the updated item
            cartModel.items[cartModel.items.indexOf(item)] = updatedItem;
            break;
          }
        }
      }
      emit(CartLoaded(List.from(_cart)));
    });

    // on<FetchCartitems>((event, emit) {
    //   emit(CartLoaded(List.from(_cart)));
    // });


on<FetchCartitems>((event, emit) async {
  try {
    final currentUser = authService.currentUser;
    if (currentUser == null) {
      emit(CartError('User not logged in'));
      return;
    }

    final cartStream = cartRepository.fetchCartItems();
    cartStream.listen((cartList) {
      final totalAmount = cartList.fold(
        0.0,
        (sum, cart) => sum + cart.items.fold(0.0, (sum, item) => sum + item.subtotal),
      );

      emit(CartLoaded(cartList, totalAmount: totalAmount));
    });
  } catch (e) {
    emit(CartError('Failed to fetch cart items'));
  }
});


  }


}



