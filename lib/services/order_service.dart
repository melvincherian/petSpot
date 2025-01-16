// class GenerateOrderId {
//   String _lastDate;
//   int _counter;

//   GenerateOrderId()
//       : _lastDate = _getCurrentDate(),
//         _counter = 0;

//   static String _getCurrentDate() {
//     final now = DateTime.now();
//     final year = now.year;
//     final month = now.month.toString().padLeft(2, '0');
//     final day = now.day.toString().padLeft(2, '0');
//     return '$year$month$day';
//   }

//   /// Generate a new order ID based on the current date and counter.
//   String generateID() {
//     final currentDate = _getCurrentDate();


//     if (_lastDate != currentDate) {
//       _counter = 0;
//       _lastDate = currentDate;
//     }


//     _counter += 1;
//     final counterString = _counter.toString().padLeft(4, '0');
//     print(generateID());
//     return 'ORDER-$currentDate-$counterString';

   
//   }
// }


import 'dart:math';

class OrderIdGenerator {
  static String generateOrderId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomValue = Random().nextInt(99999).toString().padLeft(5, '0');
    return 'ORDER_$timestamp$randomValue';
  }
}