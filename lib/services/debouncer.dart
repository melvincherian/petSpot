// import 'dart:async';
// import 'dart:ui';

// class Debouncer {
//   final Duration delay;
//   VoidCallback? _action;
//   Timer? _timer;

//   Debouncer({required this.delay});

//   // Method to trigger an action after a delay
//   void run(VoidCallback action) {
//     _action = action;
//     if (_timer != null && _timer!.isActive) {
//       _timer?.cancel();  // Cancel previous timer
//     }
//     _timer = Timer(delay, _action!); // Start a new timer
//   }
// }
