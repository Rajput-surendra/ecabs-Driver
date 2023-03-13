import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qcabs_driver/Api/constant.dart';
import 'package:qcabs_driver/Auth/BankDetails/UI/bank_details_page.dart';
import 'package:qcabs_driver/Auth/Verification/UI/verification_page.dart';
import 'package:qcabs_driver/Components/custom_button.dart';
import 'package:qcabs_driver/Components/entry_field.dart';
import 'package:qcabs_driver/Locale/locale.dart';
import 'package:qcabs_driver/Locale/strings_enum.dart';
import 'package:qcabs_driver/Model/cab_model.dart';
import 'package:qcabs_driver/Provider/UserProvider.dart';
import 'package:qcabs_driver/utils/ApiBaseHelper.dart';
import 'package:qcabs_driver/utils/PushNotificationService.dart';
import 'package:qcabs_driver/utils/Session.dart';
import 'package:qcabs_driver/utils/colors.dart';
import 'package:qcabs_driver/utils/common.dart';
import 'package:http/http.dart' as http;
import 'package:qcabs_driver/utils/constant.dart';
import 'package:qcabs_driver/utils/widget.dart';
import 'package:sizer/sizer.dart';
import '../../../Model/GetCabsModel.dart';
import '../../../Model/GetDataModel.dart';
import '../../../Model/SignUpModel.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
class RegistrationUI extends StatefulWidget {

  final String? phoneNumber;

  RegistrationUI(this.phoneNumber);

  @override
  _RegistrationUIState createState() => _RegistrationUIState();
}

class _RegistrationUIState extends State<RegistrationUI> {
  TextEditingController mobileCon = new TextEditingController();
  TextEditingController referCon = new TextEditingController();
  TextEditingController emailCon = new TextEditingController();
  TextEditingController bankCon = new TextEditingController();
  TextEditingController accountCon = new TextEditingController();
  TextEditingController codeCon = new TextEditingController();
  TextEditingController nameCon = new TextEditingController();
  TextEditingController vehicleCon = new TextEditingController();
  TextEditingController carCon = new TextEditingController();
  TextEditingController modelCon = new TextEditingController();
  TextEditingController genderCon = new TextEditingController();
  TextEditingController dobCon = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobileCon.text =widget.phoneNumber.toString();
    PushNotificationService notificationService = new PushNotificationService(
        context: context,
        onResult: (result) {
        });
    notificationService.initialise();
    getCab();
  }

  @override
  void dispose() {
    super.dispose();
  }
  List<String> brands = [];

  List<String> brandsModel = [];
  List<String> gender = ["Male","Female","Other"];
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
  PersistentBottomSheetController? persistentBottomSheetController1;
  showBottom1()async{
    persistentBottomSheetController1 = await scaffoldKey.currentState!.showBottomSheet((context) {
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
                          persistentBottomSheetController1!.setState!((){
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
  PersistentBottomSheetController? persistentBottomSheetController2;
  showBottom2()async{
    persistentBottomSheetController2 = await scaffoldKey.currentState!.showBottomSheet((context) {
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
                        persistentBottomSheetController2!.setState!((){
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
    var userdata = Provider.of<UserProvider>(context, listen: false);
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      key: scaffoldKey,
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            getTranslated(context,Strings.SIGN_UP_NOW)!,
                            style: theme.textTheme.headline4,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Text(
                            getTranslated(context,Strings.ENTER_REQ_INFO)!,
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
                      top: 90,
                      start: 24,
                      child: InkWell(
                        onTap: (){
                          requestPermission(context,1);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: _image!=null?Image.file(_image!,  height: 100,
                              width: 100,fit: BoxFit.fill,):Icon(Icons.camera_alt,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  color: theme.backgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EntryField(
                        controller: mobileCon,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        label: getTranslated(context, "ENTER_PHONE")!,
                      ),
                      EntryField(
                        controller: nameCon,
                        keyboardType: TextInputType.name,
                        label: getTranslated(context,Strings.FULL_NAME),
                      ),
                      EntryField(
                        controller: emailCon,
                        keyboardType: TextInputType.emailAddress,
                        label: getTranslated(context,Strings.EMAIL_ADD),
                      ),
                      gender.length>0?EntryField(
                        maxLength: 10,
                        readOnly: true,
                        controller: genderCon,
                        onTap: (){
                          showBottom2();
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
                      EntryField(
                        controller: referCon,
                        label: getTranslated(context, "REFER_CODE")!,
                      ),
                      SizedBox(height: 20),

                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          getTranslated(context,Strings.CAR_INFO)!,
                          style: theme.textTheme.headline4,
                        ),
                      ),
                      EntryField(
                        maxLength: 10,
                        readOnly: true,
                        controller: carCon,
                        onTap: (){
                          showBottom();
                        },
                        label:getTranslated(context, "VEHICLE_TYPE")!,
                        hint: "",
                      ),
                  carCon.text.toLowerCase()!="bike"&&modelList.length>0?EntryField(
                        maxLength: 10,
                        readOnly: true,
                        controller: modelCon,
                        onTap: (){
                          showBottom1();
                        },
                        label: "Vehicle Model",
                        hint: "",
                      ):SizedBox(),
                      EntryField(
                        maxLength: 10,
                        controller: vehicleCon,
                        label: getTranslated(context,Strings.VEHICLE_NUM),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "Bank Info",
                          style: theme.textTheme.headline4,
                        ),
                      ),
                      EntryField(
                        keyboardType: TextInputType.phone,
                        controller: accountCon,
                        maxLength: 16,
                        label: getTranslated(context, "Accountnumber")!,
                        hint: "",
                      ),
                      EntryField(
                        keyboardType: TextInputType.text,
                        controller: bankCon,
                        label: "Bank Name",
                        hint: "",
                      ),
                      EntryField(
                        maxLength: 11,
                        keyboardType: TextInputType.text,
                        controller: codeCon,
                        label: "IFSC Code",
                        hint: "",
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          getTranslated(context,Strings.DOCUMENT)!,
                          style: theme.textTheme.headline4,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20),
                          child: Text(getTranslated(context, "UPLOAD_Drive")!),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          requestPermission(context,5);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(left: 24),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: _finalImage!=null?Image.file(_finalImage!,  height: 100,
                              width: 100,fit: BoxFit.fill,):Icon(Icons.camera_alt,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20),
                          child: Text(getTranslated(context, "UPLOAD_PASS")!),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          requestPermission(context,2);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(left: 24),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: panImage!=null?Image.file(panImage!,  height: 100,
                              width: 100,fit: BoxFit.fill,):Icon(Icons.camera_alt,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20),
                          child: Text(getTranslated(context, "UPLOAD_BLUE")!),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          requestPermission(context,3);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(left: 24),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: adharImage!=null?Image.file(adharImage!,  height: 100,
                              width: 100,fit: BoxFit.fill,):Icon(Icons.camera_alt,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20),
                          child: Text(getTranslated(context, "UPLOAD_INS")!),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          requestPermission(context,6);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(left: 24),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: insuranceImage!=null?Image.file(insuranceImage!,  height: 100,
                              width: 100,fit: BoxFit.fill,):Icon(Icons.camera_alt,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20),
                          child: Text(getTranslated(context, "UPLOAD_BANK")!),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          requestPermission(context,7);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(left: 24),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: bankImage!=null?Image.file(bankImage!,  height: 100,
                              width: 100,fit: BoxFit.fill,):Icon(Icons.camera_alt,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20),
                          child: Text(getTranslated(context, "UPLOAD_VEHICLE")!),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          requestPermission(context,4);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(left: 24),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: vehicleImage!=null?Image.file(vehicleImage!,  height: 100,
                              width: 100,fit: BoxFit.fill,):Icon(Icons.camera_alt,
                                color: Colors.black),
                          ),
                        ),
                      ),
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
        height:60,
        child: CustomButton(
          text: getTranslated(context,Strings.SIGN_UP),
          onTap: (){
            if(mobileCon.text==""||mobileCon.text.length!=10){
              setSnackbar("Please Enter Valid Mobile Number", context);
              return ;
            }
            if(validateField(nameCon.text, "Please Enter Full Name")!=null){
              setSnackbar("Please Enter Full Name", context);
              return;
            }
            if(validateEmail(emailCon.text, "Please Enter Email","Please Enter Valid Email")!=null){
              setSnackbar(validateEmail(emailCon.text, "Please Enter Email","Please Enter Valid Email").toString(), context);
              return;
            }
            if(genderCon.text==""){
              setSnackbar("Please Select Gender", context);
              return ;
            }
            if(dobCon.text==""){
              setSnackbar("Please Enter Date of Birth", context);
              return ;
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
              setSnackbar("Please Enter Valid Bank Code", context);
              return ;
            }
            if(_image==null){
              setSnackbar("Please Upload Photo", context);
              return;
            }
            if(_finalImage==null){
              setSnackbar("Please Upload Document Photo", context);
              return;
            }
            if(panImage==null){
              setSnackbar("Please Upload Citizenship/Passport Photo", context);
              return;
            }
            if(adharImage==null){
              setSnackbar("Please Upload Blue Book Photo", context);
              return;
            }
            if(insuranceImage==null){
              setSnackbar("Please Upload Insurance Photo", context);
              return;
            }
            if(bankImage==null){
              setSnackbar("Please Upload Cheque Photo", context);
              return;
            }
            if(vehicleImage==null){
              setSnackbar("Please Upload Vehicle Photo", context);
              return;
            }
            setState(() {
              loading =true;
            });
            submitSubscription();
          },
        ),
      ):Container(
          width: 50,
          height: 50,
          child: Center(child: CircularProgressIndicator())),
    );
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
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = false;
  Future<void> submitSubscription() async {
    await App.init();

    ///MultiPart request
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        if (_image != null) {
          var request = http.MultipartRequest(
            'POST',
            Uri.parse(baseUrl + "driver_registration"),
          );
          Map<String, String> headers = {
            "token": App.localStorage.getString("token").toString(),
            "Content-type": "multipart/form-data"
          };
          request.files.add(
            http.MultipartFile(
              'user_image',
              _image!.readAsBytes().asStream(),
              _image!.lengthSync(),
              filename: path.basename(_image!.path),
              contentType: MediaType('image', 'jpeg'),
            ),
          );
          request.files.add(
            http.MultipartFile(
              'vehical_imege',
              vehicleImage!.readAsBytes().asStream(),
              vehicleImage!.lengthSync(),
              filename: path.basename(vehicleImage!.path),
              contentType: MediaType('image', 'jpeg'),
            ),
          );
          request.files.add(
            http.MultipartFile(
              'aadhar_card',
              adharImage!.readAsBytes().asStream(),
              adharImage!.lengthSync(),
              filename: path.basename(adharImage!.path),
              contentType: MediaType('image', 'jpeg'),
            ),
          );request.files.add(
            http.MultipartFile(
              'pan_card',
              panImage!.readAsBytes().asStream(),
              panImage!.lengthSync(),
              filename: path.basename(panImage!.path),
              contentType: MediaType('image', 'jpeg'),
            ),
          );

          request.files.add(
            http.MultipartFile(
              'driving_licence_photo',
              _finalImage!.readAsBytes().asStream(),
              _finalImage!.lengthSync(),
              filename: path.basename(_finalImage!.path),
              contentType: MediaType('image', 'jpeg'),
            ),
          );
          request.files.add(
            http.MultipartFile(
              'bank_chaque',
              bankImage!.readAsBytes().asStream(),
              bankImage!.lengthSync(),
              filename: path.basename(bankImage!.path),
              contentType: MediaType('image', 'jpeg'),
            ),
          );
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
            "user_fullname": nameCon.text,
            "user_phone": mobileCon.text,
            "gender": genderCon.text,
            "dob":dobCon.text,
            "bank_name": bankCon.text,
            "account_number": accountCon.text,
            "ifsc_code": codeCon.text,
            "car_no": vehicleCon.text,
            "car_type": cabId,
            "car_model": modelId,
            "user_email": emailCon.text.trim().toString(),
            "firebaseToken": fcmToken.toString(),
          });
          if(referCon.text!=""){
            request.fields.addAll({
              "friends_code": referCon.text,
            });
          }
          print(request.fields.toString());
          print("request: " + request.toString());
          var res = await request.send();
          print("This is response:" + res.toString());
          setState(() {
            loading = false;
          });
          print(res.statusCode);
          final respStr = await res.stream.bytesToString();
          print(respStr.toString());
          if (res.statusCode == 200) {

            Map data = jsonDecode(respStr.toString());

            if (data['status']) {
              Map info = data['data'];
              setSnackbar(data['message'].toString(), context);
              navigateScreen(context, VerificationPage(info['phone'],info['otp']));
            } else {
              setSnackbar(data['message'].toString(), context);
            }
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
  loginUser() async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "mobile_no": mobileCon.text.trim().toString(),
          "fcm_id": fcmToken.toString(),
        };
        Map response =
        await apiBase.postAPICall(Uri.parse(baseUrl + "send_otp"), data);
        print(response);
        bool status = true;
        String msg = response['message'];
        setState(() {
          loading = false;
        });
        setSnackbar(msg, context);
        if(response['status']){
           //navigateScreen(context, VerificationPage(_numberController.text.trim()));
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
  List<CabModel>  cabList = [];
  String cabId = "",cabName = "";
  List<modelModel>  modelList = [];
  String modelId = "",modelName = "";
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
              cabId = cabList[0].id;
              cabName = cabList[0].car_type;
              carCon.text = cabList[0].car_type;
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
        setSnackbar(msg, context);
        if(response['status']){
          for(var v in response['data']){
            setState(() {
              modelList.add(new modelModel(v['id'].toString(), v['car_type_id'].toString(), v['car_model'].toString()));
            });
          }
          if(modelList.length>0){
            setState(() {
              modelId = modelList[0].id;
              modelName = modelList[0].car_model;
              modelCon.text = modelList[0].car_model;
            });
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
