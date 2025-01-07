class PaymentModel {
  final String id;
  final String userReference;
  final List<PaymentItems> payment;

  PaymentModel(
      {required this.id, required this.userReference, required this.payment});

  factory PaymentModel.fromMap(Map<String, dynamic> map, String id) {
    return PaymentModel(
      id: id,
      userReference: map['userReference'] as String,
      payment: List<PaymentItems>.from(
        (map['payment'] as List<dynamic>).map(
          (pay) => PaymentItems.fromMap(pay as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userReference': userReference,
      'payment': payment,
    };
  }
}

class PaymentItems {
  final String productReference;
  final double price;
  final double subtotal;
  final String paymentStatus;
  final String transactionId;
  final String productName;

  PaymentItems(
      {required this.productReference,
      required this.price,
      required this.subtotal,
      required this.paymentStatus,
      required this.transactionId,
      required this.productName});

  factory PaymentItems.fromMap(Map<String, dynamic> map) {
    return PaymentItems(
        productReference: map['productReference'] as String,
        price: (map['price'] as num?)?.toDouble() ?? 0.0,
        subtotal: (map['subtotal'] as num?)?.toDouble() ?? 0.0,
        paymentStatus: map['paymentStatus'] as String,
        transactionId: map['transactionId'] as String,
        productName: map['productName'] as String);
  }

  Map<String, dynamic> toMap() {
    return {
      'productReference': productReference,
      'price': price,
      'subtotal': subtotal,
      'paymentStatus': paymentStatus,
      'transactionId': transactionId,
      'productName': productName,
    };
  }
}
