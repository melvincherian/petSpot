import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:second_project/models/payment_model.dart';
import 'package:second_project/screens/review_screen.dart';

class OrderDetail extends StatefulWidget {
  final PaymentModel payment;


  const OrderDetail({super.key, required this.payment});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {

   
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final ValueNotifier<Map<String, String>> productImages = ValueNotifier({});
  final ValueNotifier<Map<String, String>> productNames = ValueNotifier({});
  final ValueNotifier<String> addressName = ValueNotifier('');
  final ValueNotifier<int> phoneNumber = ValueNotifier(0);
  final ValueNotifier<int> pincode = ValueNotifier(0);
  final ValueNotifier<String> state = ValueNotifier('');
  final ValueNotifier<String> orderId = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
    _fetchAddressDetails();
 
  }



  Future<void> _fetchAddressDetails() async {
    if (widget.payment.adrress.isNotEmpty) {
      final addressDoc = await _firestore
          .collection('address')
          .doc(widget.payment.adrress)
          .get();

      if (addressDoc.exists) {
        final addressData = addressDoc.data();
        if (addressData != null) {
          addressName.value = addressData['name'] ?? 'Unknown Name';
          phoneNumber.value = addressData['phone'] ?? 0;
          pincode.value = addressData['pincode'] ?? 0;
          state.value = addressData['state'] ?? 'Unknown state';
        }
      }
    }

    final paymentDoc =
        await _firestore.collection('payment').doc(widget.payment.id).get();

    if (paymentDoc.exists) {
      orderId.value = paymentDoc.id;
    }
  }

  Future<void> _fetchProductDetails() async {
    final Map<String, String> collectionToImageField = {
      'breed': 'imageUrls',
      'foodproducts': 'imageUrls',
      'accessories': 'imageUrls',
    };

    final Map<String, String> collectionToNameField = {
      'breed': 'name',
      'foodproducts': 'foodname',
      'accessories': 'accesoryname',
    };

    for (var item in widget.payment.payment) {
      final productReference = item.productReference;
      for (final collection in collectionToImageField.keys) {
        final productDoc =
            await _firestore.collection(collection).doc(productReference).get();
        if (productDoc.exists) {
          final productData = productDoc.data();
          if (productData != null) {
            String? productName =
                productData[collectionToNameField[collection]];
            if (productName != null) {
              productNames.value = {
                ...productNames.value,
                productReference: productName
              };
            }

            String? imageUrl;
            var imageData = productData[collectionToImageField[collection]];

            if (imageData is List && imageData.isNotEmpty) {
              imageUrl = imageData[0];
            } else if (imageData is String) {
              imageUrl = imageData;
            }

            if (imageUrl != null) {
              productImages.value = {
                ...productImages.value,
                productReference: imageUrl
              };
            }
          }
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Details',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shipping Address:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ValueListenableBuilder(
              valueListenable: addressName,
              builder: (context, value, child) => Text('Name: $value'),
            ),
            ValueListenableBuilder(
              valueListenable: phoneNumber,
              builder: (context, value, child) => Text('Phone: $value'),
            ),
            ValueListenableBuilder(
              valueListenable: pincode,
              builder: (context, value, child) => Text('Pincode: $value'),
            ),
            ValueListenableBuilder(
              valueListenable: state,
              builder: (context, value, child) => Text('State: $value'),
            ),
            const SizedBox(height: 10),

              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const  Text('Order Status:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                  widget.payment.orderStatus.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.payment.orderStatus == 'pending'
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const Text('Ordered Items:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: productImages,
                builder: (context, images, child) {
                  return ValueListenableBuilder(
                    valueListenable: productNames,
                    builder: (context, names, child) {
                      return ListView.builder(
                        itemCount: widget.payment.payment.length,
                        itemBuilder: (context, index) {
                     
                          final item = widget.payment.payment[index];
                          final productImage =
                              images[item.productReference] ?? '';
                          final productName = names[item.productReference] ??
                              'Product Name Not Found';
                         
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: productImage.isNotEmpty
                                  ? Image.network(productImage,
                                      width: 60, height: 60, fit: BoxFit.cover)
                                  : const Icon(Icons.image_not_supported),
                              title: Text(productName),
                              subtitle: Text('Price: \$${item.price}'),
                              trailing: TextButton(
                                onPressed: () {
                                  print(item.productReference);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                           Reviewaddingscreen(productReference: item.productReference,),
                                           
                                    ),
                                  );
                                 print('navigating product reference is ${item.productReference}');
                                },
                                child: const Text('Write a review'),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const Divider(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Order Summary',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Shipping & Handling:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('\$${widget.payment.shippingFee}',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Estimated Tax to be collected:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('\$${widget.payment.taxFee}',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery Charge:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('\$${widget.payment.delivery}',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Grand Total:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('\$${widget.payment.totalAmount}',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
