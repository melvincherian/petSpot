part of 'address_bloc.dart';

@immutable
sealed class AddressState {}

final class AddressInitial extends AddressState {}

class AddressLoading extends AddressState{}

class AddressLoaded extends AddressState{

final List<AddressModel>address;

AddressLoaded(this.address);

}

class AddressError extends AddressState{
  final String error;

  AddressError(this.error);
}

class AddressSuccess extends AddressState{
  final String message;

  AddressSuccess(this.message);
}

class AddressSelected extends AddressState {
  final AddressModel selectedAddress;
  AddressSelected(this.selectedAddress);
}




