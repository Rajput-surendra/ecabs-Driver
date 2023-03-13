import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:qcabs_driver/DrawerPages/Home/offline_page.dart';
import 'package:qcabs_driver/DrawerPages/Rides/my_rides_page.dart';
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
import 'package:qcabs_driver/utils/common.dart';
import 'package:qcabs_driver/utils/constant.dart';
import 'package:qcabs_driver/utils/widget.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Assets/assets.dart';

class RentalRides extends StatefulWidget {
  bool selected;

  RentalRides({this.selected= false});

  @override
  State<RentalRides> createState() => _RentalRidesState();
}

class _RentalRidesState extends State<RentalRides> {
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = true;
  List<MyRideModel> rideList = [];

  getRides(type) async {
    try {
      setState(() {
        loading = true;
      });
      Map params = {
        "driver_id": curUserId,
        "type": type,
      };
      print("GET ALL COMPLETE ========= $params");
      Map response = await apiBase.postAPICall(Uri.parse(baseUrl1 + "Payment/rental_Bookint_by_driver_id"), params);
      setState(() {
        loading = false;
        rideList.clear();
      });
      if (response['status']) {
        print(response['data']);
        for(var v in response['data']){
          setState(() {
            selectedFil = "All";
            rideList.add(MyRideModel.fromJson(v));
          });
        }
      } else {
        setState(() {
          selectedFil = "All";
        });
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = widget.selected;
    if(widget.selected){
      getRides("3");
    }else{
      getRides("1");
    }

  }

  bool selected =false;
  List<String> filter = ["All", "Today", "Weekly", "Monthly"];
  String selectedFil = "All";
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          getTranslated(context, "RENTAL_RIDES")!,
          style: theme.textTheme.headline4,
        ),
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Column(
            children: [
              /*  Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                getTranslated(context,Strings.MY_RIDES)!,
                style: theme.textTheme.headline4,
              ),
            ),*/
            /*  Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(
                  getTranslated(context,Strings.LIST_OF_RIDES_COMPLETED)!,
                  style:
                  theme.textTheme.bodyText2!.copyWith(color: theme.hintColor),
                ),
              ),*/
              boxHeight(10),
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
                        getRides("1");
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
                            getTranslated(context, "upcoming")!,
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
                        getRides("3");
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
                            getTranslated(context, "Completed")!,
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
                      var now = new DateTime.now();
                      var now_1w = now.subtract(Duration(days: 7));
                      var now_1m = new DateTime(now.year, now.month-1, now.day);
                      if(selectedFil == "Today"){
                        for(int i=0;i<rideList.length;i++){
                          DateTime date = DateTime.parse(rideList[i].createdDate.toString());
                          if(now.day == date.day && now.month==date.month){
                            setState(() {
                              rideList[i].show = true;
                            });
                          }else{
                            setState(() {
                              rideList[i].show = false;
                            });
                          }
                        }
                      }
                      if(selectedFil == "Weekly"){
                        for(int i=0;i<rideList.length;i++){
                          DateTime date = DateTime.parse(rideList[i].createdDate.toString());
                          if(now_1w.isBefore(date)){
                            setState(() {
                              rideList[i].show = true;
                            });
                          }else{
                            setState(() {
                              rideList[i].show = false;
                            });
                          }
                        }
                      }
                      if(selectedFil == "Monthly"){
                        for(int i=0;i<rideList.length;i++){
                          DateTime date = DateTime.parse(rideList[i].createdDate.toString());
                          if(now_1m.isBefore(date)){
                            setState(() {
                              rideList[i].show = true;
                            });
                          }else{
                            setState(() {
                              rideList[i].show = false;
                            });
                          }
                        }
                      }
                      if(selectedFil == "All"){
                        for(int i=0;i<rideList.length;i++){
                          setState(() {
                            rideList[i].show = true;
                          });
                        }
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
                   /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RideInfoPage(rideList[index])));*/
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
                                    width:  getWidth(72),
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
                                    'Trip ID-${getString1(rideList[index].uneaqueId.toString())}',
                                    style: theme.textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${getDate(rideList[index].createdDate)}',
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    getString1(rideList[index].username.toString()),
                                    style: theme.textTheme.caption,
                                  ),
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
                        ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: theme.primaryColor,
                            size: 20,
                          ),
                          title: Text(getString1(rideList[index].pickupAddress.toString())),
                          dense: true,
                          tileColor: theme.cardColor,
                        ),
                        AnimatedTextKit(
                          animatedTexts: [
                            ColorizeAnimatedText(
                              rideList[index].bookingType
                                  .toString()
                                  .contains("Rental Booking")?"Rental Booking - ${rideList[index].start_time} - ${rideList[index].end_time}":"Schedule - ${rideList[index].pickupDate} ${rideList[index].pickupTime}",
                              textStyle: colorizeTextStyle,
                              colors: colorizeColors,
                            ),
                          ],
                          pause: Duration(milliseconds: 100),
                          isRepeatingAnimation: true,
                          totalRepeatCount: 100,
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                        Divider(),
                        rideList[index].acceptReject!="3"?Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                String url = "https://www.google.com/maps/dir/?api=1&origin=${latitude.toString()},${longitude.toString()}&destination=${rideList[index].latitude},${rideList[index].longitude}&travelmode=driving&dir_action=navigate";

                                print(url);
                                launch(url);
                                },
                              child: Container(
                                width: 30.w,
                                margin:
                                EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                                height: 5.h,
                                decoration: boxDecoration(
                                    radius: 5,
                                    bgColor: Theme.of(context).primaryColor),
                                child: Center(
                                    child: loading1?text("Map",
                                        fontFamily: fontMedium,
                                        fontSize: 10.sp,
                                        isCentered: true,
                                        textColor: Colors.white):CircularProgressIndicator(color: Colors.white,)),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  acceptStatus = true;
                                });
                                if(rideList[index].acceptReject=="1"){
                                  setState(() {
                                    rideList[index].acceptReject="6";
                                  });
                                  startRide(rideList[index].id!, "6");
                                }else{
                                  print("complete");
                                  bookingStatus(rideList[index].id!, "3");
                                }
                              },
                              child: Container(
                                width: 30.w,
                                margin:
                                EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                                height: 5.h,
                                decoration: boxDecoration(
                                    radius: 5,
                                    bgColor: Theme.of(context).primaryColor),
                                child: Center(
                                    child: !acceptStatus?text( rideList[index].acceptReject=="1" ? "Start" : "Complete",
                                        fontFamily: fontMedium,
                                        fontSize: 10.sp,
                                        isCentered: true,
                                        textColor: Colors.white):CircularProgressIndicator(color: Colors.white,)),
                              ),
                            ),
                          ],
                        ):SizedBox(),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                ):SizedBox(),
              ):Center(
                child: text(getTranslated(context, "Norides")!,fontFamily: fontMedium,fontSize: 12.sp,textColor: Colors.black),
              ):Center(child: CircularProgressIndicator()),
            ],
          ),),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
  bool loading1 = true;
  bool acceptStatus = false;
  bookingStatus(String bookingId,status1) async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "driver_id": curUserId,
          "accept_reject": status1.toString(),
          "booking_id": bookingId,
        };
        print("COMPLETE RIDE === $data");
        // return;
        Map response = await apiBase.postAPICall(
            Uri.parse(
                baseUrl1+"payment/complete_ride_driver"),
            data);
        print(response);
        print(response);
        setState(() {
          acceptStatus = false;
        });
        bool status = true;
        String msg = response['message'];
        setSnackbar(msg, context);
        if (response['status']) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> OfflinePage("")), (route) => false);
        } else {

        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
      }
    } else {
      setSnackbar("No Internet Connection", context);
    }
  }
  startRide(String bookingId,status1) async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "driver_id": curUserId,
          "accept_reject": status1.toString(),
          "booking_id": bookingId,
        };
        print("Start Ride ==== $data");
        // return;
        Map response = await apiBase.postAPICall(
            Uri.parse(
                baseUrl1+"Payment/start_ride"),
            data);
        print(response);
        print(response);
        setState(() {
          acceptStatus = false;
        });
        bool status = true;
        String msg = response['message'];
        setSnackbar(msg, context);
        if (response['status']) {
        } else {

        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
      }
    } else {
      setSnackbar("No Internet Connection", context);
    }
  }
}
