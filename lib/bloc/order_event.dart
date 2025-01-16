part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}


class PaymentSuccessEvent extends OrderEvent{
  final bool isSuccess;
  PaymentSuccessEvent(this.isSuccess);
}