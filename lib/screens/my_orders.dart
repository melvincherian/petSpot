import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:second_project/models/payment_model.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('My Orders',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('payment').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No orders found'),
            );
          }

          final payments = snapshot.data!.docs.map((doc) {
            return PaymentModel.fromMap(
              doc.data() as Map<String, dynamic>,
              doc.id,
            );
          }).toList();

          return ListView.builder(
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payment = payments[index];
              return GestureDetector(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetail()));
                },
                child: Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order ID: ${payment.orderId}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Date: ${payment.createdAt}',
                          style:
                              const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        // const SizedBox(height: 8),
                        // Text(
                        //   'Payment Method: ${payment.paymentmethod}',
                        //   style: const TextStyle(fontSize: 14, color: Colors.grey),
                        // ),
                        // const SizedBox(height: 8),
                        // Text(
                        //   'Order Status: ${payment.orderStatus}',
                        //   style: TextStyle(
                        //     fontSize: 14,
                        //     color: payment.orderStatus == 'Completed'
                        //         ? Colors.green
                        //         : Colors.red,
                        //   ),
                        // ),
                        // const SizedBox(height: 12),
                        // const Divider(),
                        // const Text(
                        //   'Order Items:',
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 14,
                        //   ),
                        // ),
                        // const SizedBox(height: 8),
                        // Column(
                        //   children: payment.payment.map((item) {
                        //     return Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 6.0),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           // Text(
                        //           //   'Product: ${item.productReference}',
                        //           //   style: const TextStyle(fontSize: 14),
                        //           // ),
                        //           // Text(
                        //           //   '\$${item.price.toStringAsFixed(2)}',
                        //           //   style: const TextStyle(
                        //           //     fontSize: 14,
                        //           //     fontWeight: FontWeight.bold,
                        //           //   ),
                        //           // ),
                        //         ],
                        //       ),
                        //     );
                        //   }).toList(),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
