import 'dart:async';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:qcabs_driver/Assets/assets.dart';
import 'package:qcabs_driver/Components/custom_button.dart';
import 'package:qcabs_driver/Components/entry_field.dart';
import 'package:qcabs_driver/DrawerPages/Home/offline_page.dart';
import 'package:qcabs_driver/DrawerPages/Wallet/send_to_bank_page.dart';
import 'package:qcabs_driver/Locale/strings_enum.dart';
import 'package:qcabs_driver/Locale/locale.dart';
import 'package:qcabs_driver/Model/wallet_model.dart';
import 'package:qcabs_driver/Routes/page_routes.dart';
import 'package:qcabs_driver/Theme/style.dart';
import 'package:qcabs_driver/utils/ApiBaseHelper.dart';
import 'package:qcabs_driver/utils/Razorpay.dart';
import 'package:qcabs_driver/utils/Session.dart';
import 'package:qcabs_driver/utils/colors.dart';
import 'package:qcabs_driver/utils/constant.dart';
import 'package:qcabs_driver/utils/widget.dart';
import 'package:sizer/sizer.dart';
import '../app_drawer.dart';

class WalletPage extends StatefulWidget {
  @override
  State<WalletPage> createState() => _WalletPageState();
}
class _WalletPageState extends State<WalletPage> {
  ApiBaseHelper apiBase = new ApiBaseHelper();
  double totalBal = 0;
  double minimumBal = 0;
  bool isNetwork = false;
  bool saveStatus = true;
  bool showText =  false;
  TextEditingController amount = new TextEditingController();
  getSetting() async {
    try {
      setState(() {
        saveStatus = false;
      });
      Map params = {
        "user_id": curUserId.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl1 + "Authentication/minimum_balance"), params);
      setState(() {
        saveStatus = true;
      });
      if (response['status']) {
        var data = response["data"][0];
        print(data);
        minimumBal = double.parse(data['wallet_amount'].toString());
        amount.text = minimumBal.toString().split(".")[0];
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }
  //Schedule Ride
  List<WalletModel> walletList = [];
  getWallet() async {
    try {
      setState(() {
        saveStatus = false;
      });
      Map params = {
        "user_id": curUserId.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl1 + "Authentication/get_wallet"), params);
      setState(() {
        saveStatus = true;
        walletList.clear();
      });
      if (response['status']) {
        var data = response["data"];
        for(var v in data){
          print(v['created_at']);
          setState(() {
            walletList.add(new WalletModel.fromJson(v));
          });
        }
        print(data);
        totalBal = double.parse(response['wallet'].toString());
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }
  List<WithdrawModel> withdrawList = [];

  getWithdraw() async {
    try {
      setState(() {
        saveStatus = false;
      });
      Map params = {
        "driver_id": curUserId.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl1 + "Authentication/get_widrwwal"), params);
      setState(() {
        saveStatus = true;
      });
      if (response['status']) {
        var data = response["data"];
        for(var v in data){
          setState(() {
            withdrawList.add(new WithdrawModel(v['id'], v['amount'], v['status'],v['added_date']));
          });
        }
        print(data);
        totalBal = double.parse(response['wallet'].toString());
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }
  bool loading = false;
  bool showWithdraw = false;
  addWallet(orderId) async {
    try {
      setState(() {
        loading = true;
      });
      Map params = {
        "user_id": curUserId.toString(),
        "Amount": amount.text.contains(".")?amount.text.toString().split(".")[0]:amount.text.toString(),
        "txn_id": orderId.toString(),
        "txn_date": DateTime.now().toString(),
        "status": "Paid",
        "gateway_name": "Razorpay",
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl1 + "Authentication/wallet"), params);
      setState(() {
        loading = false;
      });
      if (response['status']) {
        setSnackbar(response['message'], context);
          getWallet();
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSetting();
    getWallet();
    getWithdraw();
  }
  Future<bool> onWill(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OfflinePage("")), (route) => false);

    return Future.value();
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onWill,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
        ),
        drawer: AppDrawer(false),
        body: FadedSlideAnimation(
          SingleChildScrollView(
            child: saveStatus?Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          child: Text(
                            getTranslated(context,"AVAILABLE_AMOUNT")!,
                            style:
                            theme.textTheme.bodyText2!.copyWith(color: theme.hintColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            '\u{20B9}${totalBal}',
                            style: theme.textTheme.headline4,
                          ),
                        ),
                      ],
                    ),
                    /*Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          child: Text(
                            getTranslated(context,Strings.Joining)!,
                            style:
                            theme.textTheme.bodyText2!.copyWith(color: theme.hintColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            '\u{20B9}500.00',
                            style: theme.textTheme.headline4,
                          ),
                        ),
                      ],
                    ),*/
                  ],
                ),
                SizedBox(height: 32),
                Container(
                  width: getWidth(330),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            showText=!showText;
                          });
                        },
                        child: Container(
                          width: 42.w,
                          height: 5.h,
                          decoration: boxDecoration(
                              radius: 5, bgColor: Colors.grey),
                          child: Center(
                              child: text(getTranslated(context, "Addmoney")!,
                                  fontFamily: fontMedium,
                                  fontSize: 10.sp,
                                  isCentered: true,
                                  textColor: Colors.white)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  SendToBankPage(totalBal.toString(),minimumBal.toString())),
                          );
                        },
                        child: Container(
                          width: 42.w,
                          height: 5.h,
                          decoration: boxDecoration(
                              radius: 5,
                              bgColor: Theme.of(context)
                                  .primaryColor),
                          child: Center(
                              child: text(getTranslated(context, "Withdrawmoney")!,
                                  fontFamily: fontMedium,
                                  fontSize: 10.sp,
                                  isCentered: true,
                                  textColor: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
                boxHeight(10),
                showText?Container(
                  width: getWidth(330),
                  decoration: boxDecoration(radius: 10,showShadow: true),
                  child: Column(
                    children: [
                      EntryField(
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        controller: amount,
                        label: getTranslated(context, "Enteramonut")!,
                      ),
                      boxHeight(10),
                      InkWell(
                        onTap: () {
                          RazorPayHelper razorPay = new RazorPayHelper(amount.text, context, (result){
                                if(result!="error"){
                                  addWallet(result);
                                }else{
                                  setState(() {
                                    loading = false;
                                  });
                                }
                          });
                          setState(() {
                            loading = true;
                          });
                          razorPay.init();
                        },
                        child: Container(
                          width: 80.w,
                          height: 5.h,
                          decoration: boxDecoration(
                              radius: 5,
                              bgColor: Theme.of(context)
                                  .primaryColor),
                          child: Center(
                              child: !loading?text(getTranslated(context, "Addmoney")!,
                                  fontFamily: fontMedium,
                                  fontSize: 10.sp,
                                  isCentered: true,
                                  textColor: Colors.white):CircularProgressIndicator(color: Colors.white,)),
                        ),
                      ),
                      boxHeight(10),
                    ],
                  ),
                ):SizedBox(),
                boxHeight(10),
                Container(
                  width: getWidth(330),
                  child: text(totalBal<500?"Note-You need to add minimum \u{20B9}${minimumBal} to get booking request.":"Note-Please maintain \u{20B9}${minimumBal} minimum balance to take rides.",
                  fontSize: 10.sp,
                    fontFamily: fontMedium,
                    textColor: Colors.red
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getTranslated(context,"RECENT_TRANS")!,
                        style:
                            theme.textTheme.bodyText2!.copyWith(color: theme.hintColor),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            showWithdraw = !showWithdraw;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(getWidth(10)),
                          decoration: boxDecoration(radius: 10,color: MyColorName.primaryDark),
                          child: Text(
                            showWithdraw?"Hide History":getTranslated(context, "Withdrawhistory")!,
                            style:
                            theme.textTheme.bodyText2!.copyWith(color: theme.hintColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                !showWithdraw?saveStatus?walletList.length>0?ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: walletList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      tileColor: theme.backgroundColor,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                        height: getWidth(72),
                          width:  getWidth(72),
                            child: Image.network(imagePath+walletList[index].userImage.toString(), height: 60, width: 60)),
                      ),
                      title: Text(
                        walletList[index].note!=null?"${walletList[index].note}":"Transaction ID - ${walletList[index].txnId}",
                        style: theme.textTheme.headline6!.copyWith(fontSize: 17),
                      ),
                      subtitle: Text(
                        '${getDate(walletList[index].createdAt)}',
                        style: theme.textTheme.caption,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            ' \u{20B9}${walletList[index].balance}',
                            style: theme.textTheme.headline6!
                                .copyWith(color: Colors.green, fontSize: 17),
                          ),
                        /*  SizedBox(height: 4),
                          Text(
                            getTranslated(context,Strings.RIDE_INFO)! + '  >',
                            style: theme.textTheme.caption!
                                .copyWith(color: theme.primaryColor),
                          ),*/
                        ],
                      ),
                      onTap: () =>
                          Navigator.pushNamed(context, PageRoutes.rideInfoPage),
                    ),
                  ),
                )
                    :Center(
                  child: text(getTranslated(context, "Notransaction")!,fontFamily: fontMedium,fontSize: 12.sp,textColor: Colors.black),
                ):Center(child: CircularProgressIndicator()):
                saveStatus?walletList.length>0?ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: withdrawList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      tileColor: theme.backgroundColor,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(image.toString(), height: 60, width: 60),
                      ),
                      title: Text(
                        withdrawList[index].status=="0"?"Status - Pending":withdrawList[index].status=="1"?"Status - Confirm":"Status - Cancel",
                        style: theme.textTheme.headline6!.copyWith(fontSize: 17),
                      ),
                      subtitle: Text(
                        '${getDate(withdrawList[index].added_date)}',
                        style: theme.textTheme.caption,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            ' \u{20B9}${withdrawList[index].amount}',
                            style: theme.textTheme.headline6!
                                .copyWith(color: Colors.green, fontSize: 17),
                          ),
                          /*  SizedBox(height: 4),
                          Text(
                            getTranslated(context,Strings.RIDE_INFO)! + '  >',
                            style: theme.textTheme.caption!
                                .copyWith(color: theme.primaryColor),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                )
                    :Center(
                  child: text("No Withdrawal",fontFamily: fontMedium,fontSize: 12.sp,textColor: Colors.black),
                ):Center(child: CircularProgressIndicator())
              ],
            ):Center(child: CircularProgressIndicator()),
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}
class WithdrawModel{
  String id,amount,status,added_date;
  WithdrawModel(this.id, this.amount, this.status,this.added_date);
}