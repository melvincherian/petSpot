part of 'quantity_bloc.dart';

@immutable
sealed class QuantityState {}

final class QuantityInitial extends QuantityState {}


class QuantityLoading extends QuantityState{}

class QuantityLoaded extends QuantityState{


 final List<CartItem> cartItems;

  QuantityLoaded(this.cartItems);

  double get totalAmount =>
      cartItems.fold(0.0, (sum, item) => sum + item.subtotal);


 
}

class QuantityError extends QuantityState{
  final String error;
  QuantityError(this.error);
}