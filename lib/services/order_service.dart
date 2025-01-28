
import 'dart:math';

class OrderIdGenerator {
  static String generateOrderId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomValue = Random().nextInt(99999).toString().padLeft(5, '0');
    return 'ORDER_$timestamp$randomValue';
  }
}