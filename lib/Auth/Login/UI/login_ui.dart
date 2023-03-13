import 'dart:async';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qcabs_driver/Api/constant.dart';
import 'package:qcabs_driver/Auth/Registration/UI/registration_page.dart';
import 'package:qcabs_driver/Components/entry_field.dart';
import 'package:qcabs_driver/Locale/strings_enum.dart';
import 'package:qcabs_driver/Provider/UserProvider.dart';
import 'package:qcabs_driver/utils/ApiBaseHelper.dart';
import 'package:qcabs_driver/utils/Session.dart';
import 'package:qcabs_driver/utils/colors.dart';
import 'package:qcabs_driver/utils/common.dart';
import 'package:qcabs_driver/utils/constant.dart';
import 'package:sizer/sizer.dart';
import '../../../Components/custom_button.dart';
import '../../../Model/GetSignInModel.dart';
import '../../../utils/widget.dart';
import '../../Verification/UI/verification_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login_interactor.dart';
import 'package:qcabs_driver/Locale/locale.dart';
import 'login_page.dart';

class LoginUI extends StatefulWidget {
  final LoginInteractor loginInteractor;

  LoginUI(this.loginInteractor);

  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  // final TextEditingController _numberController =
  //     TextEditingController(text: '+91 9854596545');

  final _numberController = TextEditingController();
  String isoCode = '';

  var snackBar = SnackBar(
    content: Text('Can not Empty!'),
  );

  _signIn() async {
    // print("click");
    var user = Provider.of<UserProvider>(context , listen: false);
    if (_numberController.text.toString().isNotEmpty && _numberController.text.toString().length > 9 && _numberController.text.toString().length <11) {

      GetSignInModel? model =
          await getSingIn(_numberController.text.toString());
      if (model!.status == true) {

        user.userId = model.data.toString();
        user.otp = model.otp.toString();
        user.mobileno = model.phone.toString();
        user.message = model.message.toString();
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerificationPage(
                _numberController.text.trim().toString(),model.otp.toString()
            )));

        // widget.loginInteractor.loginWithMobile(isoCode, _numberController.text);

      } else {
        // Toast.show("${model.message}", duration: Toast.lengthShort, gravity:  Toast.bottom);
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // Toast.show("Toast plugin app", duration: Toast.lengthShort, gravity:  Toast.bottom);
        // Fluttertoast.showToast(
        //     msg: "This is Center Short Toast",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 16.0
        // );
      }
    } else if(_numberController.text.toString().length > 9 && _numberController.text.toString().length <11){
      Fluttertoast.showToast(
          msg: "Please Enter Valid Mobile Number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }else {
      Fluttertoast.showToast(
          msg: "Please Enter Valid Mobile Number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      // Toast.show("Toast plugin app", duration: Toast.lengthShort, gravity:  Toast.bottom);
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            color: MyColorName.primaryLite,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(flex: 5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    getTranslated(context,Strings.ENTER_YOUR)! +
                        '\n' +
                        getTranslated(context,Strings.PHONE_NUMBER)!,
                    style: theme.textTheme.headline4,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Text(
                    getTranslated(context,Strings.WILL_SEND_CODE)!,
                    style: theme.textTheme.bodyText2!
                        .copyWith(color: theme.hintColor),
                  ),
                ),
                Spacer(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  color: theme.backgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Spacer(),
                      EntryField(
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        controller: _numberController,
                        label: getTranslated(context,Strings.ENTER_PHONE),
                      ),
                      Spacer(flex: 5),
                      !loading?CustomButton(
                        onTap: (){
                          if(_numberController.text==""||_numberController.text.length!=10){
                            setSnackbar("Please Enter Valid Mobile Number", context);
                            return ;
                          }
                          setState(() {
                            loading =true;
                          });
                          loginUser();
                        },
                      ):Container(
                          width: 50,
                          child: Center(child: CircularProgressIndicator())),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = false;
  loginUser() async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "user_phone": _numberController.text.trim().toString(),
          "fcm_id": fcmToken.toString(),
        };
        Map response =
        await apiBase.postAPICall(Uri.parse(baseUrl + "send_otp_driver"), data);
        print(response);
        bool status = true;
        String msg = response['message'];
        setState(() {
          loading = false;
        });
        setSnackbar(msg, context);
        if(response['status']){
          //navigateScreen(context, RegisterPage(_numberController.text.trim()));
          navigateScreen(context, VerificationPage(_numberController.text.trim().toString(),response['otp'].toString()));
          // navigateScreen(context, VerificationPage(_numberController.text.trim()));
        }else{
          if(msg.contains("Approve")){
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Alert"),
                    content: Text("Wait For Admin Approval"),

                    actions: <Widget>[
                      ElevatedButton(
                          child: Text('OK'),
                          style:ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(MyColorName.primaryLite),),
                          /* shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.transparent)),
                                textColor: Theme.of(context).colorScheme.primary,*/
                          onPressed: () async {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                                    (route) => false);
                          }),
                    ],
                  );
                });
           /* showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Container(
                      padding: EdgeInsets.all(getWidth(10)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          text("Wait For Admin Approval",
                            fontFamily: fontMedium,
                            textColor: Colors.black,
                            isCentered:   true,
                            fontSize: 10.sp,),
                          boxHeight(20),
                          ElevatedButton(onPressed: (){
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                                    (route) => false);
                          }, child: text("OK", fontFamily: fontMedium,
                            textColor: Colors.white,
                            isCentered:   true,
                            fontSize: 10.sp,))
                        ],
                      ),),
                  );
                });*/
          }else{
            navigateScreen(context, RegisterPage(_numberController.text.trim()));
          }

        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          loading = false;
        });
      }
    } else {
      setSnackbar("No Internet Connection", context);
      setState(() {
        loading = false;
      });
    }
  }
}
