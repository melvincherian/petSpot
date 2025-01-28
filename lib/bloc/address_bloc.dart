// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_project/Firebase/address_repo.dart';
import 'package:second_project/Firebase/user_authentication.dart';
import 'package:second_project/models/address_model.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository repository;
   final AuthRepository authRepository;

  AddressBloc({required this.repository,required this.authRepository}) : super(AddressInitial()) {

    on<FetchAddressesEvent>((event, emit) async {
      emit(AddressLoading());
      try {
        final currentUser = authRepository.currentUser;
        if (currentUser == null) {
          
          emit(AddressError('User Not Logged In'));
          return;
        }

        

        final stream = repository.fetchAddresses(currentUser.uid);
        await emit.forEach(
          stream,
          onData: (addresses) => AddressLoaded(addresses),
          onError: (error, stackTrace) => AddressError('Failed to fetch addresses: $error'),
        );
      } catch (e) {
        emit(AddressError('Failed to fetch addresses: $e'));
      }
    });


   
    on<AddAddressEvent>((event, emit) async {
      try {
        final currentUser = authRepository.currentUser;
        if (currentUser == null) {
          emit(AddressError('User Not Logged In'));
          return;
        }

        final addressWithUserRef = event.address.copyWith(
          userReference: currentUser.uid,
        );

        await repository.addAddress(addressWithUserRef);
        emit(AddressSuccess('Address added successfully'));
      } catch (e) {
        emit(AddressError('Failed to add address: $e'));
      }
    });

  
     on<UpdateAddressEvent>((event, emit) async {
      try {
        await repository.updateAddress(event.address);
      } catch (e) {
        emit(AddressError('Failed to update address: $e'));
      }
    });

     on<DeleteAddressEvent>((event, emit) async {
      try {
        await repository.deleteAddress(event.id);
      } catch (e) {
        emit(AddressError('Failed to delete address: $e'));
      }
    });
  }


  
}
