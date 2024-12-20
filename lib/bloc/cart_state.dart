part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoading extends CartState{}

class CartLoaded extends CartState{
  final List<CartModel>cartItems;
  final double totalAmount;

  CartLoaded(this.cartItems,{this.totalAmount=0.0});
}

class CartError extends CartState{
  final String error;

  CartError(this.error);
}

class CartSuccess extends CartState{

final String message;

CartSuccess(this.message);

}
