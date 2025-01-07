// ignore_for_file: unnecessary_null_comparison, prefer_final_fields, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_project/models/payment_model.dart';

class CheckoutRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPayment(PaymentModel payment) async {
    if (payment == null || payment.userReference == null) {
      throw ArgumentError('payment or user reference cannot be null');
    }

    final userPaymentsnapshot = await _firestore
        .collection('payment')
        .where('userReference', isEqualTo: payment.userReference)
        .limit(1)
        .get();

    if (userPaymentsnapshot.docs.isNotEmpty) {
      final existingpaymentDoc = userPaymentsnapshot.docs.first;
      final existingpaymentData = existingpaymentDoc.data();

      final existingItems = List<PaymentItems>.from(
          (existingpaymentData['items'] as List).map(
              (item) => PaymentItems.fromMap(item as Map<String, dynamic>)));

      existingItems.addAll(payment.payment);
    }
  }

  Stream<List<PaymentModel>> fetchPayments() {
    return _firestore.collection('payment').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              PaymentModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }
}
