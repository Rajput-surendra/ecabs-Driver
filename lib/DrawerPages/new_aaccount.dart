import 'dart:async';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:qcabs_driver/DrawerPages/Rides/ride_info_page.dart';
import 'package:qcabs_driver/Locale/strings_enum.dart';
import 'package:qcabs_driver/Model/my_ride_model.dart';
import 'package:qcabs_driver/Model/rides_model.dart';
import 'package:qcabs_driver/Model/wallet_model.dart';
import 'package:qcabs_driver/Routes/page_routes.dart';
import 'package:qcabs_driver/Locale/locale.dart';
import 'package:qcabs_driver/Theme/style.dart';
import 'package:qcabs_driver/utils/ApiBaseHelper.dart';
import 'package:qcabs_driver/utils/Session.dart';
import 'package:qcabs_driver/utils/colors.dart';
import 'package:qcabs_driver/utils/constant.dart';
import 'package:qcabs_driver/utils/widget.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../Assets/assets.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with TickerProviderStateMixin{
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = true;
  List<MyRideModel> rideList = [];
  TabController? tabController;
  String total = "",commission = "",balance= "";
  String payout = "",earning = "";
  getEarning(url,type) async {
    try {
      setState(() {
        loading = true;
      });
      Map params = {
        "driver_id": curUserId,
        "type": type.toString().toLowerCase(),
      };
      Map response =
      await apiBase.postAPICall(Uri.parse(baseUrl1 + url), params);
      setState(() {
        loading = false;
        rideList.clear();
        balance = "0";
        total = "0";
        commission = "0";
        payout = "0";
      });
      if (response['status']) {
        print(response['data']);
        for(var v in response['data']){
          setState(() {
            if(response['balance_all']!=null&&response['balance_all'].toString()!="")
              balance = double.parse(response['balance_all'].toString()).toStringAsFixed(2);
            if(url=="Payment/get_account_summary_by_cash"){

            }else{
              if(response['total_amount_all']!=null&&response['total_amount_all'].toString()!="")
                payout = double.parse(response['total_amount_all'].toString()).toStringAsFixed(2);
              if(response['wallet_inc_total1']!=null&&response['wallet_inc_total1'].toString()!="")
                earning = double.parse(response['wallet_inc_total1'].toString()).toStringAsFixed(2);
            }
            if(response['total_amount']!=null&&response['total_amount'].toString()!="")
              total = double.parse(response['total_amount'].toString()).toStringAsFixed(2);
            if(response['admin_commi']!=null&&response['admin_commi'].toString()!=""){
              commission = double.parse(response['admin_commi'].toString()).toStringAsFixed(2);
            }
            rideList.add(MyRideModel.fromJson(v));
          });
        }
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
    }
  }
  String wOnlineAmount = "0",wCashAmount = "0",wOnlineAAmount = "0",wCashAAmount = "0",wReferAmount = "0",wBonusAmount = "0",wIncentiveAmount = "0",wPayAmount = "0";
  getPayout() async {
    try {

      Map params = {
        "driver_id": curUserId,
      };
      Map response =
      await apiBase.postAPICall(Uri.parse(baseUrl1 + "payment/all_amount_driver"), params);

      if (response['status']) {
        print(response['data']);
        var v = response['data'];
        setState(() {
          wOnlineAmount = v["online_amo"]!=null?v["online_amo"].toString():"0";
          wCashAmount = v["cash_amo"]!=null?v["cash_amo"].toString():"0";
          wOnlineAAmount = v["admin_comm_online"]!=null?v["admin_comm_online"].toString():"0";
          wCashAAmount = v["admin_comm_cash"]!=null?v["admin_comm_cash"].toString():"0";
          wReferAmount = v["refferal_amount"]!=null?v["refferal_amount"].toString():"0";
          wBonusAmount = v["incentive_bounus"]!=null?v["incentive_bounus"].toString():"0";
          wIncentiveAmount = v["incentive_amount"]!=null?v["incentive_amount"].toString():"0";
          wPayAmount = v["weekly_pay"]!=null?v["weekly_pay"].toString():"0";
        });
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
    }
  }
  getHistory() async {
    try {
      setState(() {
        loading = true;
      });
      Map params = {
        "driver_id": curUserId,
      };
      Map response =
      await apiBase.postAPICall(Uri.parse(baseUrl1 + "payment/weekly_pay_out_driver"), params);
      setState(() {
        loading = false;

      });
      if (response['status']) {
        print(response['data']);
        if(response['data'] is Map){
          setState(() {
            walletList.add(new WalletModel.fromJson(response['data']));
          });
        }else{
          for(var v in response['data']){
            setState(() {
              walletList.add(new WalletModel.fromJson(v));
            });
          }
        }

      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
    }
  }
  List<WalletModel> walletList = [];
  bool saveStatus = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
    tabController!.addListener(() {
        if(tabController!.index ==1){
          getEarning("Payment/get_account_summary_by_online",selectedFil);
        }
        if(tabController!.index ==0){
          getEarning("Payment/get_account_summary_by_cash",selectedFil);
        }
    });
    getHistory();
    getEarning("Payment/get_account_summary_by_cash","today");
    getPayout();
  }
  bool selected =false;
  List<String> filter = ["Today", "Weekly","Monthly"];
  String selectedFil = "Today";
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          getTranslated(context, "Myearning")!,
          style: theme.textTheme.headline4,
        ),
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
          tabs: [
            Tab(
              text: getTranslated(context, "Cashearning")!,
            ),
            Tab(
              text: getTranslated(context, "Onlinepayment")!,
            ),
            Tab(
              text: getTranslated(context, "Weeklypayout")!,
            ),
            Tab(
              text: getTranslated(context, "HISTORY")!,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                /*Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "My Earning",
                  style: theme.textTheme.headline4,
                ),
              ),*/
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${getTranslated(context, "Totalearning")} - \u{20B9}$balance",
                        style:
                        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor,fontWeight: FontWeight.bold),
                      ),
                      Text("${getTranslated(context, "CASH_EARNING")} - \u{20B9}$total",
                        style:
                        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: selected?MainAxisAlignment.spaceBetween:MainAxisAlignment.center,
                    children: [
                      Text(
                        "${getTranslated(context, "Admincommission")} - \u{20B9}$commission",
                        style:
                        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor,fontWeight: FontWeight.bold),
                      ),
                      selected?Text(
                        "${getTranslated(context, "Weeklypayout")} - \u{20B9}$payout",
                        style:
                        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor,fontWeight: FontWeight.bold),
                      ):SizedBox(),
                    ],
                  ),
                ),
                selected?Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${getTranslated(context, "Joining")} - \u{20B9}$earning",
                        style:
                        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ):SizedBox(),
                boxHeight(19),
                Wrap(
                  spacing: 3.w,
                  children: filter.map((e) {
                    return InkWell(
                      onTap: (){
                        setState(() {
                          selectedFil = e.toString();
                        });
                        getEarning("Payment/get_account_summary_by_cash",selectedFil);
                      },
                      child: Chip(
                        side: BorderSide(color: MyColorName.primaryLite),
                        backgroundColor: selectedFil==e?MyColorName.primaryLite:Colors.transparent,
                        shadowColor: Colors.transparent,
                        label: text(e,
                            fontFamily: fontMedium,
                            fontSize: 10.sp,
                            textColor: selected==e?Colors.white:Colors.black),
                      ),
                    );
                  }).toList(),
                ),
                boxHeight(19),
                !loading?rideList.length>0
                    ?ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: rideList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => rideList[index].show!?GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RideInfoPage(rideList[index],check: "yes",)));
                    },
                    child: Container(
                      margin: EdgeInsets.all(getWidth(10)),
                      decoration: boxDecoration(radius: 10,bgColor: Colors.white,showShadow: true),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                      height: getWidth(72),
                                      width: getWidth(72),
                                      decoration: boxDecoration(radius: 10,color: Colors.grey),
                                      child: Image.network(imagePath+rideList[index].userImage.toString() ,height: getWidth(72),
                                        width:  getWidth(72),)),
                                ),
                                SizedBox(width: 16),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${rideList[index].createdDate} ${rideList[index].bookingTime}',
                                      style: theme.textTheme.bodyText2,
                                    ),
                                    /* SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    getString1(rideList[index].username.toString()),
                                    style: theme.textTheme.caption,
                                  ),*/
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\u{20B9} ${rideList[index].amount}',
                                      style: theme.textTheme.bodyText2!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '${rideList[index].transaction}',
                                      textAlign: TextAlign.right,
                                      style: theme.textTheme.caption,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ):SizedBox(),
                )
                    :Center(
                  child: text(getTranslated(context, "Noearnings")!,fontFamily: fontMedium,fontSize: 12.sp,textColor: Colors.black),
                ):Center(child: CircularProgressIndicator()),
              ],
            ),),
          SingleChildScrollView(
            child: Column(
              children: [
                /*Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "My Earning",
                  style: theme.textTheme.headline4,
                ),
              ),*/
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${getTranslated(context, "Totalearning")} - \u{20B9}$balance",
                        style:
                        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor,fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${getTranslated(context, "ONLINE_EARNING")} - \u{20B9}$total",
                        style:
                        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${getTranslated(context, "Admincommission")} - \u{20B9}$commission",
                        style:
                        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor,fontWeight: FontWeight.bold),
                      ),
                    /* Text(
                        "Weekly Payout - \u{20B9}$payout",
                        style:
                        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor,fontWeight: FontWeight.bold),
                      ),*/
                    ],
                  ),
                ),
               /*Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Earning Bonus - \u{20B9}$earning",
                        style:
                        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),*/
                boxHeight(19),
                Wrap(
                  spacing: 3.w,
                  children: filter.map((e) {
                    return InkWell(
                      onTap: (){
                        setState(() {
                          selectedFil = e.toString();
                        });
                        getEarning("Payment/get_account_summary_by_online",selectedFil);
                      },
                      child: Chip(
                        side: BorderSide(color: MyColorName.primaryLite),
                        backgroundColor: selectedFil==e?MyColorName.primaryLite:Colors.transparent,
                        shadowColor: Colors.transparent,
                        label: text(e,
                            fontFamily: fontMedium,
                            fontSize: 10.sp,
                            textColor: selected==e?Colors.white:Colors.black),
                      ),
                    );
                  }).toList(),
                ),
                boxHeight(19),
                !loading?rideList.length>0?ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: rideList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => rideList[index].show!?GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RideInfoPage(rideList[index],check: "yes",)));
                    },
                    child: Container(
                      margin: EdgeInsets.all(getWidth(10)),
                      decoration: boxDecoration(radius: 10,bgColor: Colors.white,showShadow: true),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                      decoration: boxDecoration(radius: 10,color: Colors.grey),
                                      height: getWidth(72),
                                      width: getWidth(72),
                                      child: Image.network(imagePath+rideList[index].userImage.toString() ,height: getWidth(72),
                                        width:  getWidth(72),)),
                                ),
                                SizedBox(width: 16),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${rideList[index].createdDate} ${rideList[index].bookingTime}',
                                      style: theme.textTheme.bodyText2,
                                    ),
                                    /* SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    getString1(rideList[index].username.toString()),
                                    style: theme.textTheme.caption,
                                  ),*/
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\u{20B9} ${rideList[index].amount}',
                                      style: theme.textTheme.bodyText2!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '${rideList[index].transaction}',
                                      textAlign: TextAlign.right,
                                      style: theme.textTheme.caption,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ):SizedBox(),
                ):Center(
                  child: text(getTranslated(context, "Noearnings")!,fontFamily: fontMedium,fontSize: 12.sp,textColor: Colors.black),
                ):Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                /*SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text("Cash Amount : ",
                        fontSize: 10.sp,
                        fontFamily: fontMedium,
                        textColor: Colors.black),
                    text(
                        "₹" + "${wCashAmount}",
                        fontSize: 10.sp,
                        fontFamily: fontMedium,
                        textColor: Colors.black),
                  ],
                ),*/
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text("${getTranslated(context, "ONLINE_AMOUNT")} : ",
                        fontSize: 10.sp,
                        fontFamily: fontMedium,
                        textColor: Colors.black),
                    text(
                        "₹" + "${wOnlineAmount}",
                        fontSize: 10.sp,
                        fontFamily: fontMedium,
                        textColor: Colors.black),
                  ],
                ),
                /*SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text("Admin Cash Commission : ",
                        fontSize: 10.sp,
                        fontFamily: fontMedium,
                        textColor: Colors.black),
                    text(
                        "₹" + "${wCashAAmount}",
                        fontSize: 10.sp,
                        fontFamily: fontMedium,
                        textColor: Colors.black),
                  ],
                ),*/
                /*SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text("Admin Online Commission : ",
                        fontSize: 10.sp,
                        fontFamily: fontMedium,
                        textColor: Colors.black),
                    text(
                        "₹" + "${wOnlineAAmount}",
                        fontSize: 10.sp,
                        fontFamily: fontMedium,
                        textColor: Colors.black),
                  ],
                ),*/
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text("${getTranslated(context, "Referralamount")} : ",
                        fontSize: 10.sp,
                        fontFamily: fontMedium,
                        textColor: Colors.black),
                    text(
                        "₹" + "${wReferAmount}",
                        fontSize: 10.sp,
                        fontFamily: fontMedium,
                        textColor: Colors.black),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text("${getTranslated(context, "Joiningbonus")} : ",
                        fontSize: 10.sp,
                        fontFamily: fontMedium,
                        textColor: Colors.black),
                    text(
                        "₹" + "${wBonusAmount}",
                        fontSize: 10.sp,
                        fontFamily: fontMedium,
                        textColor: Colors.black),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text("${getTranslated(context, "Incentivebonus")} : ",
                        fontSize: 10.sp,
                        fontFamily: fontMedium,
                        textColor: Colors.black),
                    text(
                        "₹" + "${wIncentiveAmount}",
                        fontSize: 10.sp,
                        fontFamily: fontMedium,
                        textColor: Colors.black),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text("${getTranslated(context, "Weeklypayout")} : ",
                        fontSize: 14.sp,
                        fontFamily: fontBold,
                        textColor: Colors.black),
                    text(
                        "₹" + "${wPayAmount}",
                        fontSize: 14.sp,
                        fontFamily: fontBold,
                        textColor: Colors.black),
                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child:   Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child:  Text(
                      getTranslated(context, "Payouthistory")!,
                      style:
                      theme.textTheme.bodyText2!.copyWith(color: theme.hintColor),
                    ),
                  ),
    saveStatus?walletList.length>0?ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: walletList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Card(
                          elevation: 5,
                          margin: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: ListTile(
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                            tileColor: Colors.transparent,
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                  height: getWidth(72),
                                  width:  getWidth(72),
                                  child: Image.network(image, height: 60, width: 60)),
                            ),
                            title: Text(
                              walletList[index].note!=null?"${walletList[index].note}":"Status - ${walletList[index].status}",
                              style: theme.textTheme.titleSmall,
                            ),
                            subtitle: Text(
                              '${walletList[index].dateAdded} ${walletList[index].time}',
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
                      );
                    }
                  )
        :Center(
      child: text(getTranslated(context, "Notransaction")!,fontFamily: fontMedium,fontSize: 12.sp,textColor: Colors.black),
    )
        :Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
