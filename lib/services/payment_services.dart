import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  late Razorpay _razorpay;

  PaymentService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _externalWalletResponse);
  }

  void dispose() {
    _razorpay.clear();
  }

  void openCheckout(double totalAmount, String contact, String email) {
    double shippingCharge = 5.00;
    double tax = 3.00;
    double deliveryCharge = 20.00;

    double grandTotal = totalAmount + shippingCharge + tax + deliveryCharge;

    var options = {
      'key': 'rzp_test_x4yKuLEYJQuXwJ',
      'amount': (grandTotal * 100).toInt(), // Amount in paise
      'name': 'PetSpot',
      'description': 'E-commerce application',
      'prefill': {
        'contact': contact,
        'email': email,
      },
      'notes': {
        'Subtotal': '₹${totalAmount.toStringAsFixed(2)}',
        'Shipping Charges': '₹${shippingCharge.toStringAsFixed(2)}',
        'Tax': '₹${tax.toStringAsFixed(2)}',
        'Delivery': '₹${deliveryCharge.toStringAsFixed(2)}',
        'Total Amount': '₹${grandTotal.toStringAsFixed(2)}',
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error during payment: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        print("User not logged in");
        return;
      }

      final paymentDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('payment')
          .doc(response.orderId);

      await paymentDoc.set({
        'paymentStatus': 'success',
        'transactionId': response.paymentId,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print('Payment success updated in Firestore.');
    } catch (e) {
      print('Error updating payment status: $e');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        print("User not logged in");
        return;
      }

      final paymentDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('payments')
          .doc();

      await paymentDoc.set({
        'paymentStatus': 'failed',
        'error': {
          'code': response.code,
          'message': response.message,
        },
        'timestamp': FieldValue.serverTimestamp(),
      });

      print('Payment failure updated in Firestore.');
    } catch (e) {
      print('Error updating payment status: $e');
    }
  }

  void _externalWalletResponse(ExternalWalletResponse response) {
    print('External wallet selected: ${response.walletName}');
  }
}
