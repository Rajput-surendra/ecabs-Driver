import 'dart:async';
import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:qcabs_driver/Model/refer_model.dart';
import 'package:qcabs_driver/utils/ApiBaseHelper.dart';
import 'package:qcabs_driver/utils/Session.dart';
import 'package:qcabs_driver/utils/colors.dart';
import 'package:qcabs_driver/utils/common.dart';
import 'package:qcabs_driver/utils/constant.dart';
import 'package:qcabs_driver/utils/widget.dart';
import 'package:sizer/sizer.dart';
import 'package:social_share/social_share.dart';
import 'package:http/http.dart' as http;
class ReferEarn extends StatefulWidget {
  const ReferEarn({Key? key}) : super(key: key);

  @override
  State<ReferEarn> createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
  String referCode = "",
      title = "Sahayatri Driver App\n",
      des =
          "You can use this code to refer your friends \nto Sahayatri Driver App and get rewarded";
  bool saveStatus = true;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = true;
  String total = "0",commission = "";
  List<ReferModel> referList = [];
  String msg ="";
  getDesc() async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        var res = await http.get(Uri.parse(baseUrl1 + "payment/get_reffer_amount"));
        Map response = jsonDecode(res.body);
        print(response);
        bool status = true;
       // String msg = response['message'];
        setState(() {
          loading = false;
        });
        // setSnackbar(msg, context);
        if(response['status']){
            setState(() {
              msg = response['message'].toString();
            });
        }else{

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
  getRefer() async {
    try {
      setState(() {
        saveStatus = false;
      });
      Map params = {
        "get_referral_data": "1",
        "driver_id":curUserId,
        "refferal_code": refer.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "get_refferal_driver"), params);
      setState(() {
        saveStatus = true;
      });
      if (response['status']) {
        for (var v in response['data']) {
          setState(() {
            total = response['refferal_count'].toString();
            referList.add(new ReferModel(v['id'], v['user_name'], v['email'],
                v['mobile'], v['car_type'], v['user_image'],v['com_status']));
          });
        }
      } else {
       // setSnackbar(response['message'], context);
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
    super.initState();
    getSaved();
    getDesc();
    getRefer();
  }

  getSaved() async {
    await App.init();
    if (App.localStorage.getString("refer") != null) {
      setState(() {
        referCode = App.localStorage.getString("refer").toString();
      });
    }
  }
  List<String> filter = ["Pending", "Complete"];
  String selectedFil = "Pending";
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            getTranslated(context, "ReferEarn")!,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: MyColorName.primaryLite //<- background color to combine with the picture :-)
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              width: 20.0,
              height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                "${getTranslated(context, "Totalreferral")} - $total",
                style:
                theme.textTheme.bodyText2!.copyWith(color: theme.hintColor),
              ),
            ),
            Container(
              child: Image.asset(
                'assets/refer.png',
                height: 200.0,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 40.0),
                child: Column(children: [
                  Text(getTranslated(context, "Referralcode")!,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ))
                ])),
            Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Column(children: [
                  Text(
                      msg,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ))
                ])),
            Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Column(children: [
                  InkWell(
                    onTap: () {
                      SocialShare.copyToClipboard(refer);
                      setSnackbar("Code Copied", context);
                    },
                    child: DottedBorder(
                        dashPattern: [8, 4],
                        strokeWidth: 2,
                        child: Container(
                          height: 50,
                          width: 250,
                          color:MyColorName.primaryLite,
                          child: Center(child: Text(refer)),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                    width: 10,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10.w, bottom: 0.0, top: 0.0, right: 10.w),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: MyColorName.primaryLite,
                          ),
                          onPressed: () {
                            SocialShare.shareOptions(
                                "$title\n$des\nReferral Code - $refer\n$playUrl");
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  getTranslated(context, "Share")!,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ])),
            boxHeight(10),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  text(getTranslated(context, "Recentrefers")!,
                      fontSize: 14.sp,
                      fontFamily: fontMedium,
                      textColor: Colors.black),
                ],
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
            Container(
              child: referList.length > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: referList.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return referList[index].status.toString()==selectedFil?Card(
                          margin: EdgeInsets.all(10),
                          elevation: 3,
                          child: ListTile(
                            leading: Container(
                              height: 72,
                              width: 72,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  imagePath +
                                      referList[index].user_image.toString(),
                                  height: 72,
                                  width: 72,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            title: text(referList[index].name,
                                fontSize: 12.sp,
                                fontFamily: fontMedium,
                                textColor: Colors.black),
                            subtitle: text(referList[index].email,
                                fontSize: 10.sp,
                                fontFamily: fontMedium,
                                textColor: Colors.black45),
                           trailing: text(referList[index].status.toString(),
                               fontSize: 12.sp,
                               fontFamily: fontMedium,
                               textColor: referList[index].status.toString()=="Pending"?Colors.red:Colors.green),
                           /* trailing: Container(
                              height: 15,
                              width: 15,
                              decoration:
                                  boxDecoration(radius: 100, bgColor: Colors.red),
                            ),*/
                          ),
                        ):
                        SizedBox();
                      })
                  : Center(
                      child: text(getTranslated(context, "Norefers")!,
                          fontFamily: fontMedium,
                          fontSize: 12.sp,
                          textColor: Colors.black),
                    ),
            ),
          ]),
        ));
  }
}
