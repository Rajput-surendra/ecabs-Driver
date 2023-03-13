import 'dart:async';
import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:qcabs_driver/DrawerPages/Settings/rules.dart';
import 'package:qcabs_driver/Locale/strings_enum.dart';
import 'package:qcabs_driver/Locale/locale.dart';
import 'package:qcabs_driver/Theme/style.dart';
import 'package:qcabs_driver/utils/ApiBaseHelper.dart';
import 'package:qcabs_driver/utils/Session.dart';
import 'package:qcabs_driver/utils/common.dart';
import 'package:qcabs_driver/utils/constant.dart';
import 'package:qcabs_driver/utils/widget.dart';
import 'package:sizer/sizer.dart';
import 'app_drawer.dart';
import 'package:http/http.dart' as http;
class NotificationModel {
  String? title;
  String? message;
  String? bookingId;
  String? added_notify_date;
  NotificationModel({this.title, this.message, this.bookingId});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    bookingId = json['booking_id'];
    added_notify_date = json['added_notify_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['message'] = this.message;
    data['booking_id'] = this.bookingId;
    data['added_notify_date'] = this.added_notify_date;
    return data;
  }
}


class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    getNotification();
  }
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = true;
  List<NotificationModel> notificationList = [];

  getNotification() async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        setState(() {
          loading = true;
        });
        data = {
          "driver_id": curUserId,
        };
        var res = await http.post(Uri.parse(baseUrl1 + "payment/noti_driver_list"),body: data);
        print(Uri.parse(baseUrl1 + "payment/noti_driver_list"));
        print(data);
        print(res.body);
        Map response = jsonDecode(res.body);
        print(response);
        print(response);
        bool status = true;
        String msg = response['message'];
        setSnackbar(msg, context);
        setState(() {
          loading = false;
          notificationList.clear();
        });
        if (response['status']) {
          for(var v in response['data']){
            setState(() {
              notificationList.add(new NotificationModel.fromJson(v));
            });
          }
        } else {}
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
      }
    } else {
      setSnackbar("No Internet Connection", context);
    }
  }
  getTime(date){
    String temp = "";
    if(date!=""&&date!=null){
      int time = DateTime.now().difference(DateTime.parse(date.toString())).inHours;
      if(time > 0){
        return time.toString()+" hours ago";
      }else{
        time = DateTime.now().difference(DateTime.parse(date.toString())).inMinutes;
        return time.toString()+" minutes ago";
      }
    }
    return temp;
  }
  bool saveStatus = false;
  getDelete() async {
    try {
      setState(() {
        saveStatus = true;
      });
      Map params = {
        "driver_id": curUserId.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl1 + "payment/clear_all_noti"), params);
      setState(() {
        saveStatus = false;
      });
      if (response['status']) {
        getNotification();
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

  Future<bool> onWill(){
    Navigator.pop(context,"yes");

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
          title: Text(
           getTranslated(context, "Notification")!,
            style: theme.textTheme.headline4,
          ),
        ),
        body: FadedSlideAnimation(
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                       getTranslated(context, "Yournotification")!,
                        style:
                        theme.textTheme.bodyText2!.copyWith(color: theme.hintColor),
                      ),
                      notificationList.length>0?!saveStatus?InkWell(
                        onTap: (){
                          getDelete();
                        },
                        child: Text(
                          getTranslated(context, "Clearall")!,
                          style:
                          theme.textTheme.bodyText2!.copyWith(color: theme.hintColor),
                        ),
                      ):CircularProgressIndicator():SizedBox(),
                    ],
                  ),
                ),
                !loading?notificationList.length>0?Container(
                  color: theme.backgroundColor,
                  padding: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: notificationList.length,
                    itemBuilder: (context, index) =>    Container(
                      decoration: boxDecoration(radius: 10,showShadow: true),
                      margin: EdgeInsets.all(getWidth(10)),
                      child: ListTile(
                        onTap: (){
                          Navigator.pop(context,notificationList[index].bookingId.toString());
                        },
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        title: Text(
                          getString1(notificationList[index].title.toString()),
                          style: theme.textTheme.titleSmall,
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.symmetric( vertical: 10),
                          child: Text(getString1(notificationList[index].message.toString()) ,style: theme.textTheme.bodySmall!,),
                        ),
                        trailing: Text(
                          getTime(notificationList[index].added_notify_date),
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ),
                ):Center(
                  child: text(getTranslated(context, "Nonitification")!,fontFamily: fontMedium,fontSize: 12.sp,textColor: Colors.black),
                ):Center(child: CircularProgressIndicator(),)
              ],
            ),
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}
