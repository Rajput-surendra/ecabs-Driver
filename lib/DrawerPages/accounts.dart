import 'dart:async';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:qcabs_driver/DrawerPages/Rides/ride_info_page.dart';
import 'package:qcabs_driver/Locale/strings_enum.dart';
import 'package:qcabs_driver/Model/my_ride_model.dart';
import 'package:qcabs_driver/Model/rides_model.dart';
import 'package:qcabs_driver/Routes/page_routes.dart';
import 'package:qcabs_driver/Locale/locale.dart';
import 'package:qcabs_driver/Theme/style.dart';
import 'package:qcabs_driver/utils/ApiBaseHelper.dart';
import 'package:qcabs_driver/utils/Session.dart';
import 'package:qcabs_driver/utils/colors.dart';
import 'package:qcabs_driver/utils/constant.dart';
import 'package:qcabs_driver/utils/widget.dart';
import 'package:sizer/sizer.dart';
import '../../Assets/assets.dart';

class NewAccountPage extends StatefulWidget {
  @override
  State<NewAccountPage> createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = true;
  List<MyRideModel> rideList = [];
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
      print("URL ===== $url");
      print("PARMS ===== $params");
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
            if(response['balance_all'].toString()!=null&&response['balance_all'].toString()!="")
              balance = double.parse(response['balance_all'].toString()).toStringAsFixed(2);
            if(url=="Payment/get_account_summary_by_cash"){

            }else{
              if(response['total_amount_all'].toString()!=null&&response['total_amount_all'].toString()!="")
              payout = double.parse(response['total_amount_all'].toString()).toStringAsFixed(2);
              if(response['wallet_inc_total1'].toString()!=null&&response['wallet_inc_total1'].toString()!="")
                earning = double.parse(response['wallet_inc_total1'].toString()).toStringAsFixed(2);
            }
            if(response['total_amount'].toString()!=null&&response['total_amount'].toString()!="")
            total = double.parse(response['total_amount'].toString()).toStringAsFixed(2);
            if(response['admin_commi'].toString()!=null&&response['admin_commi'].toString()!=""){
              commission = double.parse(response['admin_commi'].toString()).toStringAsFixed(2);
            }
            rideList.add(MyRideModel.fromJson(v));
          });
        }
      } else {
      //  setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEarning("Payment/get_account_summary_by_cash","today");
  }
  bool selected =false;
  List<String> filter = ["Today", "Weekly"];
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
      ),
      body: FadedSlideAnimation(
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
                      "${!selected?"Cash":"Online"} Earning - \u{20B9}$total",
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
              Container(
                width: getWidth(322.1),
                decoration: boxDecoration(bgColor: Colors.white,radius: 10,showShadow: true, color: Theme.of(context).primaryColor, ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          selected =false;
                        });
                        getEarning("Payment/get_account_summary_by_cash",selectedFil);
                      },
                      child: Container(
                        height: getHeight(49),
                        width: getWidth(160),
                        decoration: !selected?BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(52, 61, 164, 139),
                              offset: Offset(0.0, 0.0),
                              blurRadius: 8.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ):BoxDecoration(),
                        child: Center(
                          child: text(
                            "Cash",
                            fontFamily: fontSemibold,
                            fontSize: 11.sp,
                            textColor: !selected?Colors.white:Color(0xff37778A),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          selected =true;
                        });
                        getEarning("Payment/get_account_summary_by_online",selectedFil);
                      },
                      child: Container(
                        height: getHeight(49),
                        width: getWidth(160),
                        decoration: selected?BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(52, 61, 164, 139),
                              offset: Offset(0.0, 0.0),
                              blurRadius: 8.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ):BoxDecoration(),
                        child: Center(
                          child: text(
                            "Online",
                            fontFamily: fontSemibold,
                            fontSize: 11.sp,
                            textColor: selected?Colors.white:Color(0xff37778A),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              boxHeight(19),
              Wrap(
                spacing: 3.w,
                children: filter.map((e) {
                  return InkWell(
                    onTap: (){
                      setState(() {
                        selectedFil = e.toString();
                      });
                      if(!selected){
                        getEarning("Payment/get_account_summary_by_cash",selectedFil);
                      }else{
                        getEarning("Payment/get_account_summary_by_online",selectedFil);
                      }
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
                                RideInfoPage(rideList[index])));
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
                                    child: Image.network(imagePath+rideList[index].userImage.toString() ,height: getWidth(72),
                                      width:  getWidth(72),)),
                              ),
                              SizedBox(width: 16),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${getDate(rideList[index].createdDate)}',
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
          ),),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
