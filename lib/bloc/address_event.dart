part of 'address_bloc.dart';

@immutable
sealed class AddressEvent {}

class AddAddressEvent extends AddressEvent{
  final AddressModel address;
  
  AddAddressEvent(this.address);

}

class UpdateAddressEvent extends AddressEvent{
  final AddressModel address;

  UpdateAddressEvent(this.address);
}

class DeleteAddressEvent extends AddressEvent{
  final String id;

  DeleteAddressEvent(this.id);
}

class FetchAddressesEvent extends AddressEvent {}