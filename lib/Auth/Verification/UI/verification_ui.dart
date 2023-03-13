import 'dart:async';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:qcabs_driver/Auth/Login/UI/login_page.dart';
import 'package:qcabs_driver/Auth/Verification/UI/verification_interactor.dart';
import 'package:qcabs_driver/Components/custom_button.dart';
import 'package:qcabs_driver/Components/entry_field.dart';
import 'package:qcabs_driver/Locale/locale.dart';
import 'package:qcabs_driver/Locale/strings_enum.dart';
import 'package:qcabs_driver/utils/ApiBaseHelper.dart';
import 'package:qcabs_driver/utils/Session.dart';
import 'package:qcabs_driver/utils/colors.dart';
import 'package:qcabs_driver/utils/common.dart';
import 'package:qcabs_driver/utils/constant.dart';
import 'package:qcabs_driver/utils/widget.dart';
import 'package:sizer/sizer.dart';

import '../../../DrawerPages/Home/offline_page.dart';
import '../../../Provider/UserProvider.dart';
import '../../Registration/UI/registration_page.dart';

class VerificationUI extends StatefulWidget {
  final VerificationInteractor verificationInteractor;
  String mobile, otp;

  VerificationUI(this.verificationInteractor, this.mobile, this.otp);

  @override
  _VerificationUIState createState() => _VerificationUIState();
}

class _VerificationUIState extends State<VerificationUI> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  var snackBar = SnackBar(
    content: Text('Can not Empty!'),
  );

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: FadedSlideAnimation(
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Container(
                color: MyColorName.primaryLite,
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).padding.top +
                    120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        getTranslated(context,Strings.ENTER)! +
                            '\n' +
                            getTranslated(context,Strings.VER_CODE)!,
                        style: theme.textTheme.headline4,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Text(
                        getTranslated(context,Strings.ENTER_CODE_WE)!,
                        style: theme.textTheme.bodyText2!
                            .copyWith(color: theme.hintColor),
                      ),
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    Expanded(
                      child: Container(
                        height: 500,
                        color: theme.backgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Spacer(),
                            EntryField(
                              keyboardType: TextInputType.phone,
                              maxLength: 4,
                              controller: _otpController,
                              label:
                                  getTranslated(context,Strings.ENTER_6_DIGIT).toString() +
                                      " ${widget.otp}",
                            ),
                            Spacer(flex: 5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            !loading
                ? Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: getTranslated(context,Strings.NOT_RECEIVED),
                          onTap: () =>
                              widget.verificationInteractor.notReceived(),
                          color: theme.scaffoldBackgroundColor,
                          textColor: theme.primaryColor,
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            if (_otpController.text == "" ||
                                _otpController.text.length != 4) {
                              setSnackbar("Please Enter Valid Otp", context);
                              return;
                            }
                            if (_otpController.text != widget.otp) {
                              setSnackbar("Wrong Otp", context);
                              return;
                            }
                            setState(() {
                              loading = true;
                            });
                            loginUser();
                          },
                        ),
                      ),
                    ],
                  )
                : Container(
                    width: 50,
                    child: Center(child: CircularProgressIndicator())),
          ],
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
          "user_phone": widget.mobile.trim().toString(),
          "otp": widget.otp.toString(),
        };
        Map response = await apiBase.postAPICall(
            Uri.parse(baseUrl + "verify_otp_driver"), data);
        print(response);
        bool status = true;
        String msg = response['message'];
        setState(() {
          loading = false;
        });
        setSnackbar(msg, context);
        if (response['status']) {

          if (response['data']['is_active'].toString() == "0") {
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
          } else {
            App.localStorage
                .setString("userId", response['data']['id'].toString());
            curUserId = response['data']['id'].toString();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => OfflinePage("")),
                (route) => false);
          }
        } else {}
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
