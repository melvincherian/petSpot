// ignore_for_file: use_build_context_synchronously, avoid_types_as_parameter_names, non_constant_identifier_names, unused_local_variable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:second_project/bloc/payment_bloc.dart';
import 'package:second_project/models/address_model.dart';
import 'package:second_project/models/cart_model.dart';
import 'package:second_project/models/payment_model.dart';
import 'package:second_project/screens/my_address.dart';
import 'package:second_project/screens/payment_success.dart';
import 'package:second_project/services/cart_services.dart';
import 'package:second_project/services/order_service.dart';
import 'package:second_project/services/remove_cart_item.dart';
import 'package:second_project/services/stream_cart.dart';

class CheckoutScreen extends StatefulWidget {
  final String userId;
  final AddressModel? addresscode;
  const CheckoutScreen({super.key, required this.userId, this.addresscode});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final StreamCartService _cartService = StreamCartService();
  final cartService = StreamCartService();

  void onPaymentSuccess(String userId) async {
    try {
      await cartService.clearCart(userId);
      print('Cart cleared successfully!');
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }

  late Razorpay _razorpay;

  void handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        print("User not logged in");
        return;
      }
      onPaymentSuccess(widget.userId);

      final paymentDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('payment')
          .doc(response.orderId);

      // print('fsfsfsf$paymentDoc');

      // await paymentDoc.update({
      //   'paymentStatus': 'success',
      //   'transactionId': response.paymentId,
      // });

      // print('Payment success updated in Firestore.');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PaymentSuccessScreen()),
      );
    } catch (e) {
      // print('Error updating payment status: $e');
    }
  }

  void handlePaymentError(PaymentFailureResponse response) async {
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

      await paymentDoc.update({
        'paymentStatus': 'failed',
        'error': {
          'code': response.code,
          'message': response.message,
        },
      });

      print('Payment failure updated in Firestore.');
    } catch (e) {
      print('Error updating payment status: $e');
    }
  }

  void externalWalletResponse(ExternalWalletResponse response) {}

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWalletResponse);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(double totalAmount) async {
    double shippingCharge = 5.00;
    double tax = 3.00;
    double Delivery = 20.00;
     
    double grandTotal = totalAmount + shippingCharge + tax + Delivery;
    var options = {
      'key': 'rzp_test_x4yKuLEYJQuXwJ',
      'amount': (grandTotal * 100).toInt(),
      'name': 'PetSpot',
      'description': 'E-commerce application',
      'prefill': {
        'contact': '9961593179',
        'email': 'melvincherian0190@gmail.com'
      },
      'notes': {
        'Subtotal': '₹${totalAmount.toStringAsFixed(2)}',
        'Shipping Charges': '₹${shippingCharge.toStringAsFixed(2)}',
        'Tax': '₹${tax.toStringAsFixed(2)}',
        'Delivery': '₹${Delivery.toStringAsFixed(2)}',
        'Total Amount': '₹${grandTotal.toStringAsFixed(2)}',
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error during payment$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final RemoveCartService cartService = RemoveCartService();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order overview',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<CartItem>>(
        stream: _cartService.streamCartItems(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching cart items.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            );
          } else {
            final cartItems = snapshot.data!;
            final double totalAmount =
                cartItems.fold(0.0, (sum, item) => sum + item.subtotal);
            return Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                item.productDetails?['imageUrls'] != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          item.productDetails!['imageUrls'],
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const Icon(Icons.image_not_supported,
                                        size: 70, color: Colors.grey),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.productName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'Quantity: ${item.quantity}',
                                        style: const TextStyle(fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  '\$${item.subtotal.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        final cartservices = CartService();
                                        cartservices.updateCartItemQuantity(
                                            context: context,
                                            userId: widget.userId,
                                            productReference:
                                                item.productReference,
                                            quantityChange: -1,
                                            price: item.price);
                                      },
                                      icon: const Icon(Icons.remove_circle,
                                          size: 30, color: Colors.teal),
                                    ),
                                    Text(
                                      '${item.quantity}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        final cartservices = CartService();
                                        cartservices.updateCartItemQuantity(
                                            context: context,
                                            userId: widget.userId,
                                            productReference:
                                                item.productReference,
                                            quantityChange: 1,
                                            price: item.price);
                                      },
                                      icon: const Icon(Icons.add_circle,
                                          size: 30, color: Colors.teal),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      await cartService.removeCartItem(
                                          context: context,
                                          userId: widget.userId,
                                          productReference:
                                              item.productReference);
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Cart item removal failed: $e')),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'Remove',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 80,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Subtotal:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipping fee:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$5.00',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tax fee',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('\$3', style: TextStyle(fontSize: 16))
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('\$20')
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Shipping Address',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyAddress()));
                              },
                              child: const Text('Select address'),
                            )
                          ],
                        ),
                        Text(
                          widget.addresscode != null
                              ? '${widget.addresscode!.name},${widget.addresscode!.phone}'
                              : 'No address selected',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                        const SizedBox(height: 8),
                        const Divider(color: Colors.grey),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${(totalAmount + 5.00 + 3 + 20).toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: () async {
                      final currentUser = FirebaseAuth.instance.currentUser;
                      if (currentUser == null) {
                        print("User not logged in");
                        return;
                      }

                      if (widget.addresscode == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Please select an address before proceeding."),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      final orderId = OrderIdGenerator.generateOrderId();
                      const shippingFee = 5.0;
                      const taxFee = 3.0;
                      const deliveryFee = 20.0;
                      final totalAmountWithFees =
                      totalAmount + shippingFee + taxFee + deliveryFee;
                      final payment = PaymentModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        userReference: currentUser.uid,
                        paymentStatus: 'success',
                        paymentmethod: 'razorpay',
                        orderId: orderId,
                        createdAt: DateTime.now().toString(),
                        orderStatus: 'pending',
                        totalAmount: totalAmountWithFees,
                        shippingFee: shippingFee,
                        taxFee: taxFee,
                        delivery: deliveryFee,
                        adrress: widget.addresscode!.id,                    payment: cartItems.map((item) {
                          return PaymentItems(
                            productReference: item.productReference,
                            price: item.price,
                            subtotal: item.subtotal,
                          );
                        }).toList(),
                      );

                      context
                          .read<PaymentBloc>()
                          .add(AddPayment(payment: payment));
                      openCheckout(totalAmount);
                      // onPaymentSuccess(widget.userId);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Adopt now  \$${(totalAmount + 5.00 + 3 + 20).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          
        },
      ),
    );
  }
}
