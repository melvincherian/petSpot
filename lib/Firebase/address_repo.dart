// ignore_for_file: avoid_print, unnecessary_null_comparison, unused_local_variable, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_project/models/address_model.dart';

class AddressRepository{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

Future<void> addAddress(AddressModel address) async {
  try {
    if (address == null || address.userReference == null) {
      throw ArgumentError('Address or user reference cannot be null');
    }

    final userAddress = await _firestore
        .collection('address')
        .where('userReference', isEqualTo: address.userReference)
        .limit(1)
        .get();
      await _firestore.collection('address').add(address.toMap());
  } catch (e) {
    print('Error adding address: $e');
  }
}

    Stream<List<AddressModel>> fetchAddresses(String userReference) {
    return _firestore
        .collection('address')
        .where('userReference', isEqualTo: userReference)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AddressModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  Future<void>updateAddress(AddressModel address)async{
    try{
        await _firestore.collection('address').doc(address.id).update(address.toMap());
    }catch(e){
      print('Error updating address $e');
    }
   

  }

  Future<void>deleteAddress(String id)async{
    try{
      await _firestore.collection('address').doc(id).delete();

    }catch(e){
      print('Error deleting address $e');
    }
  }

}