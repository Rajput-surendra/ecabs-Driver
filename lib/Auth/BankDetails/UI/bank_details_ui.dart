import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:qcabs_driver/Api/constant.dart';
import 'package:qcabs_driver/Assets/assets.dart';
import 'package:qcabs_driver/Components/custom_button.dart';
import 'package:qcabs_driver/Components/entry_field.dart';
import 'package:qcabs_driver/Locale/locale.dart';
import 'package:qcabs_driver/Locale/strings_enum.dart';
import 'package:qcabs_driver/utils/Session.dart';

import '../../../DrawerPages/Home/offline_page.dart';
import '../../../Model/UpdateBankDetailModel.dart';
import '../../../Provider/UserProvider.dart';

class BankDetailsUI extends StatefulWidget {
  // final BankDetailsInteractor bankDetailsInteractor;

  // BankDetailsUI(this.bankDetailsInteractor);

  @override
  _BankDetailsUIState createState() => _BankDetailsUIState();
}

class _BankDetailsUIState extends State<BankDetailsUI> {
  // TextEditingController _accNumberController =
  //     TextEditingController(text: '5555 5555 5555 5555');
  // TextEditingController _bankNameController =
  //     TextEditingController(text: 'New York Bank');
  // TextEditingController _bankCodeController =
  //     TextEditingController(text: 'BNY45121');

  final _bankNameController = TextEditingController();
  final _accNumberController = TextEditingController();

  final _bankCodeController = TextEditingController();

  var snackBar = SnackBar(
    content: Text('Can not Empty!'),
  );

  _bankIn() async {
    var user = Provider.of<UserProvider>(context, listen: false);
    // var user = Provider.of<UserProvider>(context);
    if (_accNumberController.text.toString().isNotEmpty &&
        _bankNameController.text.toString().isNotEmpty &&
        _bankCodeController.text.toString().isNotEmpty) {
      UpdateBankDetailModel? model = await getUpdateBankDetails(
          "${user.userId}",
          _bankNameController.text,
          _accNumberController.text,
          _bankCodeController.text);
      if (model!.status == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => OfflinePage("")),
            (route) => false);

        // widget.bankDetailsInteractor.addBank();

      } else {
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else if (_accNumberController.text.toString().isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Enter Account Number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (_bankNameController.text.toString().isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Enter Bank Name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (_bankCodeController.text.toString().isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Enter Bank Code",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    _accNumberController.dispose();
    _bankNameController.dispose();
    _bankCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(
      body: FadedSlideAnimation(
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Container(
                height: size.height + 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppBar(),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Image.asset(
                        Assets.Logo,
                        height: 72,
                        alignment: AlignmentDirectional.centerStart,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        getTranslated(context,Strings.ENTER_BANK_DETAILS)!,
                        style: theme.textTheme.headline4,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Text(
                        getTranslated(context,Strings.YOU_WILL_GET)!,
                        style: theme.textTheme.bodyText2!
                            .copyWith(color: theme.hintColor),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: Container(
                        // height: MediaQuery.of(context).size.height * 0.61,
                        color: theme.backgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            EntryField(
                              controller: _accNumberController,
                              label: getTranslated(context,Strings.ACC_NUM),
                              keyboardType: TextInputType.number,
                            ),
                            EntryField(
                              controller: _bankNameController,
                              label: getTranslated(context,Strings.BANK_NAME),
                            ),
                            EntryField(
                              controller: _bankCodeController,
                              label: getTranslated(context,Strings.BANK_CODE),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                // Expanded(
                //   child: CustomButton(
                //     text: getTranslated(context,Strings.SKIP),
                //     // onTap: () =>
                //         // widget.bankDetailsInteractor.skip(),
                //     color: theme.scaffoldBackgroundColor,
                //     textColor: theme.primaryColor,
                //   ),
                // ),
                Expanded(
                  child: CustomButton(
                    text: getTranslated(context,Strings.ADD_BANK),
                    // onTap: () {},
                    onTap: () => _bankIn(),
                    //     widget.bankDetailsInteractor.addBank(),
                  ),
                ),
              ],
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
