part of 'selectaddress_bloc.dart';

@immutable
sealed class SelectaddressEvent {}

class ToggleAddressSelection extends SelectaddressEvent{
  final String addressId;

  ToggleAddressSelection(this.addressId);
}

class ClearSelectedAddresses extends SelectaddressEvent{}

class DeleteSelectedAddress extends SelectaddressEvent{}
