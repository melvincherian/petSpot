import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_project/models/cart_model.dart';

part 'quantity_event.dart';
part 'quantity_state.dart';

class QuantityBloc extends Bloc<QuantityEvent, QuantityState> {
  QuantityBloc() : super(QuantityLoading()) {
    on<QuantityEvent>((event, emit) {
   
    });

    
  }
}


// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'cart_event.dart';
// import 'cart_state.dart';
// import 'package:second_project/models/cart_model.dart';

// class CartBloc extends Bloc<CartEvent, CartState> {
//   CartBloc() : super(CartLoading()) {
//     on<LoadCart>(_onLoadCart);
//     on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
//   }

//   Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
//     emit(CartLoading());
//     try {
//       final cartItems = await _fetchCartItems(event.userId);
//       emit(CartLoaded(cartItems));
//     } catch (e) {
//       emit(CartError('Failed to load cart: $e'));
//     }
//   }

//   Future<void> _onUpdateCartItemQuantity(
//       UpdateCartItemQuantity event, Emitter<CartState> emit) async {
//     try {
//       if (state is CartLoaded) {
//         final currentState = state as CartLoaded;

//         final updatedCartItems = List<CartItem>.from(currentState.cartItems);
//         final itemIndex = updatedCartItems.indexWhere(
//             (item) => item.productReference == event.productReference);

//         if (itemIndex != -1) {
//           final currentQuantity = updatedCartItems[itemIndex].quantity;
//           final newQuantity = currentQuantity + event.quantityChange;

//           if (newQuantity < 1) {
//             updatedCartItems.removeAt(itemIndex);
//           } else {
//             updatedCartItems[itemIndex] = updatedCartItems[itemIndex].copyWith(
//               quantity: newQuantity,
//               subtotal: newQuantity * event.price,
//             );
//           }

//           // Update Firestore
//           await _updateFirestoreCart(
//               event.userId, updatedCartItems, event.productReference);

//           emit(CartLoaded(updatedCartItems));
//         }
//       }
//     } catch (e) {
//       emit(CartError('Failed to update quantity: $e'));
//     }
//   }

//   Future<List<CartItem>> _fetchCartItems(String userId) async {
//     // Same logic for fetching cart items from Firestore
//     // Replace with your implementation
//   }

//   Future<void> _updateFirestoreCart(
//       String userId, List<CartItem> updatedCartItems, String productReference) async {
//     // Logic to update Firestore
//     // Replace with your implementation
//   }
// }

