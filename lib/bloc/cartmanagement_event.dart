part of 'cartmanagement_bloc.dart';

@immutable
sealed class CartmanagementEvent {}

class FetchcartItems extends CartmanagementEvent{}

class AddCartItems extends CartmanagementEvent{
  final CartModel cartitem;
  AddCartItems(this.cartitem);
}

class RemoveCartItem extends CartmanagementEvent{

final String itemId;

RemoveCartItem(this.itemId);

}