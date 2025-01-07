part of 'selectaddress_bloc.dart';

@immutable
sealed class SelectaddressState {}

final class SelectaddressInitial extends SelectaddressState {}

class AddressSelectionUpdated extends SelectaddressState{
  final Set<String>selectedAddress;
  AddressSelectionUpdated(this.selectedAddress);
}


class AddressActionSuccess extends SelectaddressState {
  final String message;

  AddressActionSuccess(this.message);
}

class AddressActionFailure extends SelectaddressState {
  final String error;

  AddressActionFailure(this.error);
}
