part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

class AddPayment extends PaymentEvent{
  final PaymentModel payment;
  AddPayment(this.payment);
}

class FetchPaymentsEvent extends PaymentEvent{}