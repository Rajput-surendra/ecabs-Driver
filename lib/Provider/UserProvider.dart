import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier{
  var userId;
  var otp;
  var mobileno;
  var message;
  void onChange(value){
   userId = value;
   otp = value;
   mobileno = value;
   message = value;
   notifyListeners();
  }

}