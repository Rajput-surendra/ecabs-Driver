/*fonts*/
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

const fontRegular = 'Regular';
const fontMedium = 'Medium';
const fontSemibold = 'Semibold';
const fontBold = 'Bold';
/* font sizes*/
const textSizeSmall = 12.0;
const textSizeSMedium = 14.0;
const textSizeMedium = 16.0;
const textSizeLargeMedium = 18.0;
const textSizeNormal = 20.0;
const textSizeLarge = 24.0;
const textSizeXLarge = 34.0;

/* margin */

const spacing_control_half = 2.0;
const spacing_control = 4.0;
const spacing_standard = 8.0;
const spacing_middle = 10.0;
const spacing_standard_new = 16.0;
const spacing_large = 24.0;
const spacing_xlarge = 32.0;
const spacing_xxLarge = 40.0;


final int timeOut = 60;
const int perPage = 10;

final String appName = 'e cabs Driver';
bool notificationStatus = true;
int notificationId = 1;
final String packageName = 'com.ecabs.driver';
const String languageCode = 'languageCode';
final String baseUrl = 'https://developmentalphawizz.com/taxi_new/api/Authentication/';
final String playUrl = "https://play.google.com/store/apps/details?id=$packageName";
String? curUserId;
String? curTikId = '';
String? fcmToken;
String? term = "";
String? privacy = '';
String? returned = "";
String? delivery = "";
String? company = "";
String address="";
String homeAddress="";
double latitude=0;
double longitude = 0;
String proImage="";
int likeCount = 0;
String bookingId ="";
String bankName = "",accountNumber = "",code="",cheque = "",insurance = "";
String name="",email="",mobile="",image = "",drivingImage = "",brand = "",model2 = "", number = "",refer ="",panCard ="",adharCard = "",vehicle = "";
bool doLock = false;
String rating = "0";
bool notification = true;
String gender1 = "",dob = "";
String profileStatus = "";
String razorPayKey="rzp_test_UUBtmcArqOLqIY";
String razorPaySecret="NTW3MUbXOtcwUrz5a4YCshqk";
final String baseUrl1 = 'https://developmentalphawizz.com/taxi_new/api/';

double getHeight(double height){
  double tempHeight = 0.0;
  tempHeight = ((height * 100)/812).h;
  return tempHeight;
}
double getWidth(double width){
  double tempWidth = 0.0;
  tempWidth = ((width * 100)/375).w;
  return tempWidth;
}

Widget boxWidth(double width){
  return SizedBox(width: getWidth(width),);
}

Widget boxHeight(double height){
  return SizedBox(height: getHeight(height),);
}

navigateScreen(BuildContext context,Widget widget){
  Navigator.push(
      context,
      PageTransition(
        child: widget,
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: 500),
      ));
}
navigateBackScreen(BuildContext context,Widget widget){
  Navigator.pushReplacement(
      context,
      PageTransition(
        child: widget,
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: 500),
      ));
}
back(BuildContext context){
  Navigator.pop(context);
}
