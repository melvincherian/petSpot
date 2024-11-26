// import 'dart:async';

// import 'package:flutter/material.dart';

// class TimerProvider with ChangeNotifier{
//   int _start=30;
//   bool _isButtonDisabled=true;
//   Timer?_timer;

//   int get start=>_start;
//   bool get isButtonDisabled=>_isButtonDisabled;

  
//   TimerProvider(){
//     startTimer();
//   }

//   void startTimer(){
//     _isButtonDisabled=true;
//     _start=30;
//     _timer=Timer.periodic(const Duration(seconds: 1), (timer){
//        if(_start==0)  {
//         _isButtonDisabled=false;
//         _timer?.cancel();
//        } 
//        else{
//         _start--;
//        }
//        notifyListeners();

//     });
//   }
//   void resetTimer(){
//     _timer?.cancel();
//     startTimer();
//     notifyListeners();
//   }
  
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
    
//   }
// }