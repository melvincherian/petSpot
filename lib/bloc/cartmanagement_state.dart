part of 'cartmanagement_bloc.dart';

@immutable
sealed class CartmanagementState {}

final class CartmanagementInitial extends CartmanagementState {}

class CartLoadingmanagement extends CartmanagementState{}

class CartLoadedmanagement extends CartmanagementState{
  final List<CartModel>cartItems;

  CartLoadedmanagement(this.cartItems);


}

class Cartmanagementerror extends CartmanagementState{
  final String error;

  Cartmanagementerror(this.error);
}

class CartmanagementSuccess extends CartmanagementState{
  final String message;

  CartmanagementSuccess(this.message);
}
