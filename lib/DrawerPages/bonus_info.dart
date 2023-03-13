import 'dart:async';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:qcabs_driver/Assets/assets.dart';
import 'package:qcabs_driver/Components/custom_button.dart';
import 'package:qcabs_driver/Components/entry_field.dart';
import 'package:qcabs_driver/DrawerPages/app_drawer.dart';
import 'package:qcabs_driver/Locale/strings_enum.dart';
import 'package:qcabs_driver/Locale/locale.dart';
import 'package:qcabs_driver/Model/details_model.dart';
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

class BonusInfo extends StatefulWidget {
  String title,type;

  BonusInfo(this.title, this.type);

  @override
  State<BonusInfo> createState() => _BonusInfoState();
}

class _BonusInfoState extends State<BonusInfo> {
  ApiBaseHelper apiBase = new ApiBaseHelper();
  double totalBal = 0;
  double joinBonus = 0;
  double minimumBal = 0;
  bool isNetwork = false;
  bool saveStatus = true;
  bool showText = false;
  TextEditingController amount = new TextEditingController();

  List<WalletModel> walletList = [];
  List<DetailModel> detailList = [];
  getDetail() async {
    try {
      setState(() {
        saveStatus = false;
      });
      Map params = {
        "driver_id": curUserId.toString(),
        "type":widget.type,
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl1 + "Payment/joining_incentive_list"), params);
      setState(() {
        saveStatus = true;
      });
      if (response['status']) {
        var data = response["data"];
        for (var v in data) {
          if(v['complte_sta']!="pending")
          setState(() {
            detailList.add(new DetailModel.fromJson(v));
          });
        }
        print(data);
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
    //getSetting();
    // getWallet();
    getDetail();
  }
  List<String> filter = ["Pending", "Complete"];
  String selectedFil = "Complete";
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          widget.title,
          style: theme.textTheme.headline4,
        ),
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: saveStatus
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Text(
                  "All Transactions",
                  style: theme.textTheme.bodyText2!
                      .copyWith(color: theme.hintColor),
                ),
              ),
              boxHeight(10),
              saveStatus
                  ? detailList.length > 0
                  ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: detailList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => detailList[index].complteSta.toString().toLowerCase()==selectedFil.toLowerCase()?Padding(
                  padding: EdgeInsets.only(bottom: 4.0),
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 6),
                      tileColor: theme.backgroundColor,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                            image
                                .toString(),
                            height: 60,
                            width: 60),
                      ),
                      title: Text(
                        getTimeDate(detailList[index].startDate.toString())+"-"+getTimeDate(detailList[index].endDate.toString()),
                        style: theme.textTheme.headline6!
                            .copyWith(fontSize: 17),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(
                              '${getTranslated(context, "TRIP")}-${detailList[index].trips}',
                              fontFamily: fontMedium,
                              fontSize: 10.sp,
                              textColor: MyColorName
                                  .colorTextPrimary),
                          int.parse(detailList[index].trips.toString())-int.parse(detailList[index].count.toString())>0?text("Left Trip-${int.parse(detailList[index].trips.toString())-int.parse(detailList[index].count.toString())}",
                              fontFamily: fontMedium,
                              fontSize: 10.sp,
                              textColor: MyColorName
                                  .colorTextPrimary):SizedBox(),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        children: [
                          Text(
                            ' \u{20B9}${detailList[index].amount}',
                            style: theme.textTheme.headline6!
                                .copyWith(
                                color: Colors.green,
                                fontSize: 17),
                          ),
                          /*  SizedBox(height: 4),
                        Text(
                          getTranslated(context,Strings.RIDE_INFO)! + '  >',
                          style: theme.textTheme.caption!
                              .copyWith(color: theme.primaryColor),
                        ),*/
                        ],
                      ),
                      onTap: () => Navigator.pushNamed(
                          context, PageRoutes.rideInfoPage),
                    ),
                  ),
                ):SizedBox(),
              )
                  : Center(
                child: text(getTranslated(context, "Notransaction")!,
                    fontFamily: fontMedium,
                    fontSize: 12.sp,
                    textColor: Colors.black),
              )
                  : Center(child: CircularProgressIndicator())
            ],
          )
              : Center(child: CircularProgressIndicator()),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
