import 'dart:async';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:qcabs_driver/Assets/assets.dart';
import 'package:qcabs_driver/Components/custom_button.dart';
import 'package:qcabs_driver/Components/entry_field.dart';
import 'package:qcabs_driver/DrawerPages/app_drawer.dart';
import 'package:qcabs_driver/DrawerPages/bonus_info.dart';
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

class JoiningBonus extends StatefulWidget {
  @override
  State<JoiningBonus> createState() => _JoiningBonusState();
}

class _JoiningBonusState extends State<JoiningBonus> with TickerProviderStateMixin {
  ApiBaseHelper apiBase = new ApiBaseHelper();
  double totalBal = 0;
  double joinBonus = 0;
  double minimumBal = 0;
  bool isNetwork = false;
  bool saveStatus = true;
  bool showText = false;
  TabController? tabController;
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
        minimumBal = double.parse(data['wallet_balance'].toString());
        amount.text = minimumBal.toString();
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

  List<WalletModel> walletList = [];
  List<DetailModel> detailList = [];

  getDetail(type) async {
    try {
      setState(() {
        saveStatus = false;
      });
      Map params = {
        "driver_id": curUserId.toString(),
        "type":type,
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl1 + "Payment/get_incentive_driver"), params);
      setState(() {
        saveStatus = true;
        detailList.clear();
      });
      if (response['status']) {
        var data = response["data"];
        for (var v in data) {
          setState(() {
            detailList.add(new DetailModel.fromJson(v));
          });
        }
        print(data);
        totalBal = double.parse(response['Total_earning_bouns'].toString());
        if(response['Total_joi_bouns']!=null)
        joinBonus = double.parse(response['Total_joi_bouns'].toString());
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

  getWallet() async {
    try {
      setState(() {
        saveStatus = false;
      });
      Map params = {
        "driver_id": curUserId.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl1 + "Payment/get_eligile_incetive"), params);
      setState(() {
        saveStatus = true;
      });
      if (response['status']) {
        var data = response["data"];
        for (var v in data) {
          setState(() {
            walletList.add(new WalletModel.fromJson(v));
          });
        }
        print(data);
        totalBal = double.parse(response['total'].toString());
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

  addWallet(orderId) async {
    try {
      setState(() {
        loading = true;
      });
      Map params = {
        "user_id": curUserId.toString(),
        "Amount": amount.text.contains(".")
            ? amount.text.toString().split(".")[0]
            : amount.text.toString(),
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
    //getSetting();
   // getWallet();
    tabController = new TabController(length: 2, vsync: this);
    getDetail("incentive");
  }
  List<String> filter = ["Pending", "Complete"];
  String selectedFil = "Pending";
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          padding: EdgeInsets.all(5),
          indicator: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.white
          ),
          onTap: (index){
            setState(() {
              tabController!.index = index;
            });
            if(index==0){
              getDetail("incentive");
            }else{
              getDetail("join");
            }
          },
          tabs: [
            Tab(
              text: "${getTranslated(context, "Joining")}",
            ),
            Tab(
              text: getTranslated(context, "Joiningbonus")!,
            ),
          ],
        ),
      ),
      drawer: AppDrawer(false),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: saveStatus
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    tabController!.index == 0
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> BonusInfo("Earning Bonus", "0")));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 16),
                                child: Text(
                                  getTranslated(context, "Earningamount")!,
                                  style: theme.textTheme.bodyText2!
                                      .copyWith(color: theme.hintColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '\u{20B9}${totalBal}',
                                  style: theme.textTheme.headline4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        /*InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> BonusInfo("Joining Bonus", "1")));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  "Joining Bonus",
                                  style: theme.textTheme.bodyText2!
                                      .copyWith(color: theme.hintColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '\u{20B9}${joinBonus}',
                                  style: theme.textTheme.headline4,
                                ),
                              ),
                            ],
                          ),
                        ),*/
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context1) {
                                  return Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        boxHeight(20),
                                        text(getTranslated(context, "INCENTIVE")!,
                                            fontFamily: fontMedium,
                                            textColor:
                                                MyColorName.colorTextPrimary,
                                            fontSize: 14.sp),
                                        boxHeight(10),
                                        Container(
                                          margin: EdgeInsets.all(getWidth(10)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              text(getTranslated(context, "FROM_DATE")!,
                                                  fontFamily: fontMedium,
                                                  fontSize: 10.sp,
                                                  textColor: MyColorName
                                                      .colorTextPrimary),
                                              text(getTranslated(context, "TRIP")!,
                                                  fontFamily: fontMedium,
                                                  fontSize: 10.sp,
                                                  textColor: MyColorName
                                                      .colorTextPrimary),
                                              text(getTranslated(context, "EARNING")!,
                                                  fontFamily: fontMedium,
                                                  fontSize: 10.sp,
                                                  textColor: MyColorName
                                                      .colorTextPrimary),
                                              text(getTranslated(context, "LEFT")!,
                                                  fontFamily: fontMedium,
                                                  fontSize: 10.sp,
                                                  textColor: MyColorName
                                                      .colorTextPrimary),
                                            ],
                                          ),
                                        ),
                                        ListView.builder(
                                            itemCount: detailList.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return detailList[index].complteSta.toString().toLowerCase()!="complete"
                                                  ?Container(
                                                margin: EdgeInsets.all(getWidth(10)),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    text(getTimeDate(DateTime.parse(detailList[index].startDate.toString()))+"-"+getTimeDate(DateTime.parse(detailList[index].endDate.toString())),
                                                        fontFamily: fontMedium,
                                                        fontSize: 10.sp,
                                                        textColor: MyColorName
                                                            .colorTextPrimary),
                                                    text("${detailList[index].trips}",
                                                        fontFamily: fontMedium,
                                                        fontSize: 10.sp,
                                                        textColor: MyColorName
                                                            .colorTextPrimary),
                                                    text("₹${detailList[index].amount}",
                                                        fontFamily: fontMedium,
                                                        fontSize: 10.sp,
                                                        textColor: MyColorName
                                                            .colorTextPrimary),
                                                    text("${int.parse(detailList[index].trips.toString())-int.parse(detailList[index].count.toString())}/${DateTime.parse(detailList[index].endDate.toString()).difference(DateTime.parse(detailList[index].startDate.toString())).inDays} days",
                                                        fontFamily: fontMedium,
                                                        fontSize: 10.sp,
                                                        textColor: MyColorName
                                                            .colorTextPrimary),
                                                  ],
                                                ),
                                              )
                                                  :SizedBox();
                                            }),
                                        boxHeight(20),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            width: 20.w,
                            height: 5.h,
                            margin: EdgeInsets.all(getWidth(14)),
                            decoration: boxDecoration(
                                radius: 5,
                                bgColor: Theme.of(context).primaryColor),
                            child: Center(
                                child: text(getTranslated(context, "INFO")!,
                                    fontFamily: fontMedium,
                                    fontSize: 10.sp,
                                    isCentered: true,
                                    textColor: Colors.white)),
                          ),
                        )
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
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /*InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> BonusInfo("Earning Bonus", "0")));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 16),
                                child: Text(
                                  "Earning Bonus",
                                  style: theme.textTheme.bodyText2!
                                      .copyWith(color: theme.hintColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '\u{20B9}${totalBal}',
                                  style: theme.textTheme.headline4,
                                ),
                              ),
                            ],
                          ),
                        ),*/
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> BonusInfo("Joining Bonus", "1")));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                 getTranslated(context, "Joiningamount")!,
                                  style: theme.textTheme.bodyText2!
                                      .copyWith(color: theme.hintColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '\u{20B9}${joinBonus}',
                                  style: theme.textTheme.headline4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context1) {
                                  return Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        boxHeight(20),
                                        text(getTranslated(context, "INCENTIVE")!,
                                            fontFamily: fontMedium,
                                            textColor:
                                            MyColorName.colorTextPrimary,
                                            fontSize: 14.sp),
                                        boxHeight(10),
                                        Container(
                                          margin: EdgeInsets.all(getWidth(10)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              text(getTranslated(context, "FROM_DATE")!,
                                                  fontFamily: fontMedium,
                                                  fontSize: 10.sp,
                                                  textColor: MyColorName
                                                      .colorTextPrimary),
                                              text(getTranslated(context, "TRIP")!,
                                                  fontFamily: fontMedium,
                                                  fontSize: 10.sp,
                                                  textColor: MyColorName
                                                      .colorTextPrimary),
                                              text(getTranslated(context, "EARNING")!,
                                                  fontFamily: fontMedium,
                                                  fontSize: 10.sp,
                                                  textColor: MyColorName
                                                      .colorTextPrimary),
                                              text(getTranslated(context, "LEFT")!,
                                                  fontFamily: fontMedium,
                                                  fontSize: 10.sp,
                                                  textColor: MyColorName
                                                      .colorTextPrimary),
                                            ],
                                          ),
                                        ),
                                        ListView.builder(
                                            itemCount: detailList.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return       detailList[index].complteSta.toString().toLowerCase()!="complete"?Container(
                                                margin: EdgeInsets.all(getWidth(10)),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    text(getTimeDate(DateTime.parse(detailList[index].startDate.toString()))+"-"+getTimeDate(DateTime.parse(detailList[index].endDate.toString())),
                                                        fontFamily: fontMedium,
                                                        fontSize: 10.sp,
                                                        textColor: MyColorName
                                                            .colorTextPrimary),
                                                    text("${detailList[index].trips}",
                                                        fontFamily: fontMedium,
                                                        fontSize: 10.sp,
                                                        textColor: MyColorName
                                                            .colorTextPrimary),
                                                    text("₹${detailList[index].amount}",
                                                        fontFamily: fontMedium,
                                                        fontSize: 10.sp,
                                                        textColor: MyColorName
                                                            .colorTextPrimary),
                                                    text("${int.parse(detailList[index].trips.toString())-int.parse(detailList[index].count.toString())}/${DateTime.parse(detailList[index].endDate.toString()).difference(DateTime.parse(detailList[index].startDate.toString())).inDays} days",
                                                        fontFamily: fontMedium,
                                                        fontSize: 10.sp,
                                                        textColor: MyColorName
                                                            .colorTextPrimary),
                                                  ],
                                                ),
                                              ):SizedBox();
                                            }),
                                        boxHeight(20),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            width: 20.w,
                            height: 5.h,
                            margin: EdgeInsets.all(getWidth(14)),
                            decoration: boxDecoration(
                                radius: 5,
                                bgColor: Theme.of(context).primaryColor),
                            child: Center(
                                child: text(getTranslated(context, "INFO")!,
                                    fontFamily: fontMedium,
                                    fontSize: 10.sp,
                                    isCentered: true,
                                    textColor: Colors.white)),
                          ),
                        )
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
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Text(
                        getTranslated(context,"RECENT_TRANS")!,
                        style: theme.textTheme.bodyText2!
                            .copyWith(color: theme.hintColor),
                      ),
                    ),
                    boxHeight(10),
                    Wrap(
                      spacing: 3.w,
                      children: filter.map((e) {
                        return InkWell(
                          onTap: (){
                            setState(() {
                              selectedFil = e.toString();
                            });
                          },
                          child: Chip(
                            side: BorderSide(color: MyColorName.primaryLite),
                            backgroundColor: selectedFil==e?MyColorName.primaryLite:Colors.transparent,
                            shadowColor: Colors.transparent,
                            label: text(e,
                                fontFamily: fontMedium,
                                fontSize: 10.sp,
                                textColor: selectedFil==e?Colors.white:Colors.black),
                          ),
                        );
                      }).toList(),
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
                                            '${getTranslated(context, "TRIP")!}-${detailList[index].trips}',
                                              fontFamily: fontMedium,
                                              fontSize: 10.sp,
                                              textColor: MyColorName
                                                  .colorTextPrimary),
                                          int.parse(detailList[index].trips.toString())-int.parse(detailList[index].count.toString())>0
                                              ? text("Left Trip-${int.parse(detailList[index].trips.toString())-int.parse(detailList[index].count.toString())}",
                                              fontFamily: fontMedium,
                                              fontSize: 10.sp,
                                              textColor: MyColorName
                                                  .colorTextPrimary)
                                              :SizedBox(),
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
