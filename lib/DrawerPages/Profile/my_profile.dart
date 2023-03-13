import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qcabs_driver/DrawerPages/Home/offline_page.dart';
import 'package:qcabs_driver/Locale/locale.dart';
import 'package:qcabs_driver/Model/cab_model.dart';
import 'package:qcabs_driver/utils/ApiBaseHelper.dart';
import 'package:qcabs_driver/utils/Session.dart';
import 'package:qcabs_driver/utils/colors.dart';
import 'package:qcabs_driver/utils/common.dart';
import 'package:qcabs_driver/utils/constant.dart';
import 'package:qcabs_driver/utils/widget.dart';
import 'package:sizer/sizer.dart';
import '../../Assets/assets.dart';
import '../../Components/custom_button.dart';
import '../../Components/entry_field.dart';
import '../../Locale/strings_enum.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  TextEditingController _nameController =
      TextEditingController();
  TextEditingController _emailController =
      TextEditingController();
  TextEditingController genderCon = new TextEditingController();
  TextEditingController dobCon = new TextEditingController();
  TextEditingController modelCon = new TextEditingController();
  TextEditingController bankCon = new TextEditingController();
  TextEditingController accountCon = new TextEditingController();
  TextEditingController codeCon = new TextEditingController();
  List<String> gender = ["Male","Female","Other"];
  @override
  void initState() {
    super.initState();

    nameCon.text = name;
    emailCon.text = email;
    vehicleCon.text = number;
    carCon.text = brand;
    genderCon.text = gender1;
    dobCon.text = dob;
    bankCon.text = bankName;
    codeCon.text = code;
    accountCon.text = accountNumber;
    carCon.text = brand;
    modelId = model2;
    getCab();
  }
  DateTime startDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2023));
    if (picked != null) {
      setState(() {
        startDate = picked;
        dobCon.text = DateFormat("yyyy-MM-dd").format(startDate);
      });
    }
  }
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
  PersistentBottomSheetController? persistentBottomSheetController1;
  showBottom1()async{
    persistentBottomSheetController1 = await scaffoldKey.currentState!.showBottomSheet((context) {
      return Container(
        decoration: boxDecoration(radius: 0,showShadow: true,color: Colors.white),
        padding: EdgeInsets.all(getWidth(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            boxHeight(20),
            text("Select Gender",textColor: MyColorName.colorTextPrimary,fontSize: 12.sp,fontFamily: fontBold),
            boxHeight(20),
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: gender.length,
                  itemBuilder:(context, index) {
                    return  InkWell(
                      onTap: (){
                        persistentBottomSheetController1!.setState!((){
                          genderCon.text = gender[index];
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        color: genderCon.text==gender[index]?MyColorName.primaryLite.withOpacity(0.2):Colors.white,
                        padding: EdgeInsets.all(getWidth(10)),
                        child: text(gender[index].toString(),textColor: MyColorName.colorTextPrimary,fontSize: 10.sp,fontFamily: fontMedium),
                      ),
                    );
                  }),
            ),
            boxHeight(40),
          ],
        ),

      );
    });
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            getTranslated(context,Strings.MY_PROFILE)!,
                            style: theme.textTheme.headline4,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Text(
                            getTranslated(context,Strings.YOUR_ACCOUNT_DETAILS)!,
                            style: theme.textTheme.bodyText2!
                                .copyWith(color: theme.hintColor),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 72),
                          height: 72,
                          color: theme.backgroundColor,
                        ),
                      ],
                    ),
                    PositionedDirectional(
                      start: 24,
                      top: 80,
                      child: InkWell(
                        onTap: (){
                          if(profileStatus=="0"){
                            return;
                          }
                          requestPermission(context, 1);
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: _image==null?Image.network(image,height: 100,width: 100,fit: BoxFit.fill,colorBlendMode: profileStatus=="0"?BlendMode.hardLight:BlendMode.color,color: profileStatus=="0"?Colors.white.withOpacity(0.4):Colors.transparent,):Image.file(_image!,height: 100,width: 100,fit: BoxFit.fill,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: theme.backgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EntryField(
                        label: getTranslated(context, "ENTER_PHONE")!,
                        initialValue: mobile,
                        readOnly: true,
                      ),
                      EntryField(
                        label: getTranslated(context,Strings.FULL_NAME),
                        controller: nameCon,
                        keyboardType: TextInputType.name,
                      ),
                      EntryField(
                        label: getTranslated(context,Strings.EMAIL_ADD),
                        controller: emailCon,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      gender.length>0?EntryField(
                        maxLength: 10,
                        readOnly: true,
                        controller: genderCon,
                        onTap: (){
                          showBottom1();
                        },
                        label: getTranslated(context, "GENDER")!,
                      ):SizedBox(),
                      EntryField(
                        label: getTranslated(context, "DOB")!,
                        controller: dobCon,
                        readOnly: true,
                        onTap: (){
                          selectDate(context);
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 28),
                      // Divider(
                      //   color: Colors.black,
                      //   thickness: 5,
                      // ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          getTranslated(context,Strings.CAR_INFO)!,
                          style: theme.textTheme.headline4,
                        ),
                      ),
                      EntryField(
                        controller: carCon,
                        //initialValue: brand,
                        onTap: (){
                        ///  showBottom();
                        },
                        label: getTranslated(context,Strings.CAR_BRAND),
                        hint: getTranslated(context,Strings.SELECT_CAR_BRAND),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        readOnly: true,
                      ),
                      carCon.text.toLowerCase()!="bike"?EntryField(
                       onTap: (){
                         showBottom2();
                       },
                        controller: modelCon,
                        readOnly: true,
                        label: getTranslated(context,Strings.CAR_MODEL),
                        hint: getTranslated(context,Strings.SELECT_CAR_MODEL),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ):SizedBox(),
                      EntryField(
                    //    initialValue: number,
                        controller: vehicleCon,
                        label: getTranslated(context,Strings.VEHICLE_NUM),
                        hint: getTranslated(context,Strings.ENTER_VEHICLE_NUM),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          getTranslated(context, "BANK_INFO")!,
                          style: theme.textTheme.headline4,
                        ),
                      ),
                      EntryField(
                        maxLength: 16,
                        keyboardType: TextInputType.phone,
                        controller: accountCon,
                        label: getTranslated(context, "Accountnumber")!,
                        hint: "",
                      ),
                      EntryField(
                        keyboardType: TextInputType.text,
                        controller: bankCon,
                        label:  getTranslated(context, "BANK_NAME")!,
                        hint: "",
                      ),
                      EntryField(
                        maxLength: 11,
                        keyboardType: TextInputType.text,
                        controller: codeCon,
                        label: getTranslated(context, "BANK_CODE")!,
                        hint: "",
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          getTranslated(context,Strings.DOCUMENT)!,
                          style: theme.textTheme.headline4,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 20),
                          child: Text(getTranslated(context, "UPLOAD_Drive")!),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          if(profileStatus=="0"){
                            return;
                          }
                          requestPermission(context, 5);
                        },
                        child: Container(
                          width: getWidth(300),
                          padding: const EdgeInsets.only(
                              left: 30, right: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child:_finalImage==null?Image.network(drivingImage,height: 200,fit: BoxFit.fill,colorBlendMode: profileStatus=="0"?BlendMode.hardLight:BlendMode.color,color: profileStatus=="0"?Colors.white.withOpacity(0.4):Colors.transparent,):
                            Image.file(_finalImage!,  height: 100,
                              width: 100,fit: BoxFit.fill,),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 20),
                          child: Text(getTranslated(context, "UPLOAD_PASS")!),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          if(profileStatus=="0"){
                            return;
                          }
                          requestPermission(context, 2);
                        },
                        child: Container(
                          width: getWidth(300),
                          padding: const EdgeInsets.only(
                              left: 30, right: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: panImage==null?Image.network(panCard,height: 200,fit: BoxFit.fill,colorBlendMode: profileStatus=="0"?BlendMode.hardLight:BlendMode.color,color: profileStatus=="0"?Colors.white.withOpacity(0.4):Colors.transparent,):Image.file(panImage!,  height: 100,
                            width: 100,fit: BoxFit.fill,),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 20),
                          child: Text(getTranslated(context, "UPLOAD_BLUE")!),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          if(profileStatus=="0"){
                            return;
                          }
                          requestPermission(context, 3);
                        },
                        child: Container(
                          width: getWidth(300),
                          padding: const EdgeInsets.only(
                              left: 30, right: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: adharImage==null?Image.network(adharCard,height: 200,fit: BoxFit.fill,colorBlendMode: profileStatus=="0"?BlendMode.hardLight:BlendMode.color,color: profileStatus=="0"?Colors.white.withOpacity(0.4):Colors.transparent,):Image.file(adharImage!,  height: 100,
                              width: 100,fit: BoxFit.fill,)
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 20),
                          child: Text(getTranslated(context, "UPLOAD_INS")!),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          if(profileStatus=="0"){
                            return;
                          }
                          requestPermission(context, 6);
                        },
                        child: Container(
                          width: getWidth(300),
                          padding: const EdgeInsets.only(
                              left: 30, right: 20),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: insuranceImage==null?Image.network(insurance,height: 200,fit: BoxFit.fill,colorBlendMode: profileStatus=="0"?BlendMode.hardLight:BlendMode.color,color: profileStatus=="0"?Colors.white.withOpacity(0.4):Colors.transparent,):Image.file(insuranceImage!,  height: 100,
                                width: 100,fit: BoxFit.fill,)
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 20),
                          child: Text(getTranslated(context, "UPLOAD_BANK")!),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          if(profileStatus=="0"){
                            return;
                          }
                          requestPermission(context, 7);
                        },
                        child: Container(
                          width: getWidth(300),
                          padding: const EdgeInsets.only(
                              left: 30, right: 20),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: bankImage==null?Image.network(cheque,height: 200,fit: BoxFit.fill,colorBlendMode: profileStatus=="0"?BlendMode.hardLight:BlendMode.color,color: profileStatus=="0"?Colors.white.withOpacity(0.4):Colors.transparent,):Image.file(bankImage!,  height: 100,
                                width: 100,fit: BoxFit.fill,)
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 20),
                          child: Text(getTranslated(context, "Vehicleimage")!),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          if(profileStatus=="0"){
                            return;
                          }
                          requestPermission(context, 4);
                        },
                        child: Container(
                          width: getWidth(300),
                          padding: const EdgeInsets.only(
                              left: 30, right: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: vehicleImage==null?Image.network(vehicle,height: 200,fit: BoxFit.fill,colorBlendMode: profileStatus=="0"?BlendMode.hardLight:BlendMode.color,color: profileStatus=="0"?Colors.white.withOpacity(0.4):Colors.transparent,):Image.file(vehicleImage!,  height: 100,
                              width: 100,fit: BoxFit.fill,),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
      bottomNavigationBar: !loading?Container(
        width: getWidth(375),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: getWidth(375),
              child: CustomButton(
                icon: Icons.circle,
                textColor: profileStatus=="0"?Colors.yellow:profileStatus=="1"?Colors.green:Colors.red,
                text: profileStatus=="0"?getTranslated(context, "WAIT")!:profileStatus=="1"?getTranslated(context, "APPROVED")!:getTranslated(context, "REJECTED")!,
                onTap: (){

                },
              ),
            ),
           Container(
             height:60,
             child: CustomButton(
                text: getTranslated(context, "Updateprofile")!,
                onTap: profileStatus=="0"?(){
                  setSnackbar("Please Wait For Review", context);
                }:(){
                 /* if(mobileCon.text==""||mobileCon.text.length!=10){
                    setSnackbar("Please Enter Valid Mobile Number", context);
                    return ;
                  }*/
                  if(validateField(nameCon.text, "Please Enter Full Name")!=null){
                    setSnackbar("Please Enter Full Name", context);
                    return;
                  }
                  if(validateEmail(emailCon.text, "Please Enter Email","Please Enter Valid Email")!=null){
                    setSnackbar(validateEmail(emailCon.text, "Please Enter Email","Please Enter Valid Email").toString(), context);
                    return;
                  }
                  if(vehicleCon.text==""||vehicleCon.text.length!=10){
                    setSnackbar("Please Enter Valid Vehicle Number", context);
                    return ;
                  }
                  if(accountCon.text==""||accountCon.text.length<10){
                    setSnackbar("Please Enter Valid Account Number", context);
                    return ;
                  }
                  if(bankCon.text==""){
                    setSnackbar("Please Enter Valid Bank Name", context);
                    return ;
                  }
                  if(codeCon.text==""||codeCon.text.length!=11){
                    setSnackbar("Please Enter Valid Code", context);
                    return ;
                  }
                  setState(() {
                    loading =true;
                  });
                  submitSubscription();
                },
              ),
           ),
          ],
        ),
      ):Container(
          width: 50,
          height: 50,
          child: Center(child: CircularProgressIndicator())),
    );
  }
  Future<void> submitSubscription() async {
    await App.init();

    ///MultiPart request
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(baseUrl + "update_driver_profile"),
        );
        Map<String, String> headers = {
          "token": App.localStorage.getString("token").toString(),
          "Content-type": "multipart/form-data"
        };
        if(_image!=null)
          request.files.add(
            http.MultipartFile(
              'user_image',
              _image!.readAsBytes().asStream(),
              _image!.lengthSync(),
              filename: path.basename(_image!.path),
              contentType: MediaType('image', 'jpeg'),
            ),
          );
        if(vehicleImage!=null)
          request.files.add(
            http.MultipartFile(
              'vehical_imege',
              vehicleImage!.readAsBytes().asStream(),
              vehicleImage!.lengthSync(),
              filename: path.basename(vehicleImage!.path),
              contentType: MediaType('image', 'jpeg'),
            ),
          );
        if(adharImage!=null)
          request.files.add(
            http.MultipartFile(
              'aadhar_card',
              adharImage!.readAsBytes().asStream(),
              adharImage!.lengthSync(),
              filename: path.basename(adharImage!.path),
              contentType: MediaType('image', 'jpeg'),
            ),
          );
        if(panImage!=null)
          request.files.add(
            http.MultipartFile(
              'pan_card',
              panImage!.readAsBytes().asStream(),
              panImage!.lengthSync(),
              filename: path.basename(panImage!.path),
              contentType: MediaType('image', 'jpeg'),
            ),
          );
        if(_finalImage!=null)
          request.files.add(
            http.MultipartFile(
              'driving_licence_photo',
              _finalImage!.readAsBytes().asStream(),
              _finalImage!.lengthSync(),
              filename: path.basename(_finalImage!.path),
              contentType: MediaType('image', 'jpeg'),
            ),
          );
        if(bankImage!=null)
        request.files.add(
          http.MultipartFile(
            'bank_chaque',
            bankImage!.readAsBytes().asStream(),
            bankImage!.lengthSync(),
            filename: path.basename(bankImage!.path),
            contentType: MediaType('image', 'jpeg'),
          ),
        );
        if(insuranceImage!=null)
        request.files.add(
          http.MultipartFile(
            'insurance',
            insuranceImage!.readAsBytes().asStream(),
            insuranceImage!.lengthSync(),
            filename: path.basename(insuranceImage!.path),
            contentType: MediaType('image', 'jpeg'),
          ),
        );
        request.headers.addAll(headers);
        request.fields.addAll({
          "user_id":curUserId.toString(),
          "gender": genderCon.text,
          "dob":dobCon.text,
          "account_number": accountCon.text,
          "ifsc_code": codeCon.text,
          "bank_name": bankCon.text,
          "user_fullname": nameCon.text,
          "user_phone": mobileCon.text,
          "car_no": vehicleCon.text,
          "car_type": cabId,
          "car_model": modelId,
          "user_email": emailCon.text.trim().toString(),
          // "firebaseToken": "no data",
        });
       /* if(referCon.text!=""){
          request.fields.addAll({
            "friends_code": referCon.text,
          });
        }*/
        print("request: " + request.toString());
        var res = await request.send();
        print("This is response:" + res.toString());
        setState(() {
          loading = false;
        });
        print(res.statusCode);
        if (res.statusCode == 200) {
          final respStr = await res.stream.bytesToString();
          print(respStr.toString());
          Map data = jsonDecode(respStr.toString());

          if (data['status']) {
            Map info = data['data'];
            setSnackbar(data['message'].toString(), context);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> OfflinePage("")), (route) => false);
          } else {
            setSnackbar(data['message'].toString(), context);
          }
        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          loading = true;
        });
      }
    } else {
      setSnackbar("No Internet Connection", context);
      setState(() {
        loading = true;
      });
    }
  }
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  PersistentBottomSheetController? persistentBottomSheetController;

  showBottom()async{
    persistentBottomSheetController = await scaffoldKey.currentState!.showBottomSheet((context) {
      return Container(
        decoration: boxDecoration(radius: 0,showShadow: true,color: Colors.white),
        padding: EdgeInsets.all(getWidth(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            boxHeight(20),
            text(getTranslated(context, "VEHICLE_TYPE")!,textColor: MyColorName.colorTextPrimary,fontSize: 12.sp,fontFamily: fontBold),
            boxHeight(20),
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cabList.length,
                  itemBuilder:(context, index) {
                    return  InkWell(
                      onTap: (){
                        persistentBottomSheetController!.setState!((){
                          cabId = cabList[index].id;
                          carCon.text = cabList[index].car_type;
                          cabName = cabList[index].car_type;
                        });
                        Navigator.pop(context);
                        getModel();
                      },
                      child: Container(
                        color: cabId==cabList[index].id?MyColorName.primaryLite.withOpacity(0.2) :Colors.white,
                        padding: EdgeInsets.all(getWidth(10)),
                        child: text(cabList[index].car_type.toString(),textColor: MyColorName.colorTextPrimary,fontSize: 10.sp,fontFamily: fontMedium),
                      ),
                    );
                  }),
            ),
            boxHeight(40),
          ],
        ),

      );
    });
  }
  PersistentBottomSheetController? persistentBottomSheetController2;
  showBottom2()async{
    persistentBottomSheetController2 = await scaffoldKey.currentState!.showBottomSheet((context) {
      return SingleChildScrollView(
        child: Container(
          decoration: boxDecoration(radius: 0,showShadow: true,color: Colors.white),
          padding: EdgeInsets.all(getWidth(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              boxHeight(20),
              text("Select Vehicle Model",textColor: MyColorName.colorTextPrimary,fontSize: 12.sp,fontFamily: fontBold),
              boxHeight(20),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: modelList.length,
                    itemBuilder:(context, index) {
                      return  InkWell(
                        onTap: (){
                          persistentBottomSheetController2!.setState!((){
                            modelId = modelList[index].id;
                            modelCon.text = modelList[index].car_model;
                            modelName = modelList[index].car_model;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          color: modelId==modelList[index].id?MyColorName.primaryLite.withOpacity(0.2):Colors.white,
                          padding: EdgeInsets.all(getWidth(10)),
                          child: text(modelList[index].car_model.toString(),textColor: MyColorName.colorTextPrimary,fontSize: 10.sp,fontFamily: fontMedium),
                        ),
                      );
                    }),
              ),
              boxHeight(40),
            ],
          ),

        ),
      );
    });
  }
  void requestPermission(BuildContext context,int i) async{
    if (await Permission.camera.isPermanentlyDenied||await Permission.storage.isPermanentlyDenied) {

      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
    }
    else{
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.storage,
      ].request();
// You can request multiple permissions at once.

      if(statuses[Permission.camera]==PermissionStatus.granted&&statuses[Permission.storage]==PermissionStatus.granted){
        getImage(ImgSource.Both, context,i);

      }else{
        if (await Permission.camera.isDenied||await Permission.storage.isDenied) {

          // The user opted to never again see the permission request dialog for this
          // app. The only way to change the permission's status now is to let the
          // user manually enable it in the system settings.
          openAppSettings();
        }else{
          setSnackbar("Oops you just denied the permission", context);
        }
      }
    }

  }
  File? _image,_finalImage,panImage,vehicleImage,adharImage,insuranceImage,bankImage;
  Future getImage(ImgSource source, BuildContext context,int i) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    getCropImage(context, i, image);
  }
  void getCropImage(BuildContext context,int i,var image) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.lightBlueAccent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    setState(() {
      if(i==1){
        _image = File(croppedFile!.path);
      }else  if(i==2){
        panImage = File(croppedFile!.path);
      }else  if(i==4){
        vehicleImage = File(croppedFile!.path);
      }else if(i==3){
        adharImage = File(croppedFile!.path);
      }
      else if(i==6){
        insuranceImage = File(croppedFile!.path);
      }
      else if(i==7){
        bankImage = File(croppedFile!.path);
      }
      else{
        _finalImage = File(croppedFile!.path);
      }
    });
  }
  List<CabModel>  cabList = [];
  String cabId = "",cabName = "";
  List<modelModel>  modelList = [];
  String modelId = "",modelName = "";
  TextEditingController mobileCon = new TextEditingController();
  TextEditingController referCon = new TextEditingController();
  TextEditingController emailCon = new TextEditingController();
  TextEditingController nameCon = new TextEditingController();
  TextEditingController vehicleCon = new TextEditingController();
  TextEditingController carCon = new TextEditingController();
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = false;
  getCab() async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        var res = await http.get(Uri.parse(baseUrl + "get_cabs"));
        Map response = jsonDecode(res.body);
        print(response);
        bool status = true;
        String msg = response['message'];
        setState(() {
          loading = false;
        });
        // setSnackbar(msg, context);
        if(response['status']){
          for(var v in response['data']){
            setState(() {
              cabList.add(new CabModel(v['id'],v['car_type'],v['car_image'], v['status']));
            });
          }
          if(cabList.length>0){
            setState(() {
             /* if(cabId==""){
                cabId = cabList[0].id;
                cabName = cabList[0].car_type;
                carCon.text = cabList[0].car_type;
              }else{
                int i =cabList.indexWhere((element) => element.id==cabId);
                if(i!=-1){
                  cabId = cabList[i].id;
                  cabName = cabList[i].car_type;
                  carCon.text = cabList[i].car_type;
                }

              }*/
              if(carCon.text==""){
                cabId = cabList[0].id;
                cabName = cabList[0].car_type;
                carCon.text = cabList[0].car_type;
              }else{
                int i =cabList.indexWhere((element) => element.car_type==carCon.text);
                cabId = cabList[i].id;
                cabName = cabList[i].car_type;
                carCon.text = cabList[i].car_type;
              }

            });
          }
          getModel();

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
  getModel() async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "mobile_no": mobileCon.text.trim().toString(),
          "cab_id": cabId,
        };
        Map response =
        await apiBase.postAPICall(Uri.parse(baseUrl + "get_model"), data);
        print(response);
        print(response);
        bool status = true;
        String msg = response['message'];
        setState(() {
          modelList.clear();
          loading = false;
        });
        //setSnackbar(msg, context);
        if(response['status']){
          for(var v in response['data']){
            setState(() {
              modelList.add(new modelModel(v['id'].toString(), v['car_type_id'].toString(), v['car_model'].toString()));
            });
          }
          if(modelList.length>0){
            if(modelId!=""){
              int i = modelList.indexWhere((element) => element.id==modelId);
              if(i!=-1){
                setState(() {
                  modelId = modelList[i].id;
                  modelName = modelList[i].car_model;
                  modelCon.text = modelList[i].car_model;
                });
              }else{

              }

            }else{
              setState(() {
                modelId = modelList[0].id;
                modelName = modelList[0].car_model;
                modelCon.text = modelList[0].car_model;
              });
            }
          }

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
}
