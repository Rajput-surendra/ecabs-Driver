import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcabs_driver/utils/constant.dart';

import '../Model/GetCabsModel.dart';
import '../Model/GetDataModel.dart';
import '../Model/GetDriverDeModel.dart';
import '../Model/GetSignInModel.dart';
import '../Model/SignUpModel.dart';
import '../Model/UpdateBankDetailModel.dart';

Future<GetSignInModel?> getSingIn(mobileNo) async {
  var headers = {'Cookie': 'ci_session=ukbt8oivnrcl42o8ekk0ao2h045uoskh'};
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          baseUrl +'driver_newregistration'));
  request.fields.addAll({'mobile': '$mobileNo'});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // print(await response.stream.bytesToString());
    final str = await response.stream.bytesToString();
    return GetSignInModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<SignUpModel?> getSignup(userId, userfullName, userEmail, userPhone,
    firebaseToken, carType, carModel, carNo, image) async {
  var headers = {'Cookie': 'ci_session=dspcl69lbrn7sqtv89eh67sa3mq97c6d'};
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          baseUrl + 'update_profile'));
  request.fields.addAll({
    'user_id': '$userId',
    'user_fullname': '$userfullName',
    'user_email': '$userEmail',
    'user_phone': '$userPhone',
    'firebaseToken': '$firebaseToken',
    'car_type': '$carType',
    'car_model': '$carModel',
    'car_no': '$carNo'
  });
  request.files.add(await http.MultipartFile.fromPath(
      'driving_licence_photo', '$image'));
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // print(await response.stream.bytesToString());
    final str = await response.stream.bytesToString();
    return SignUpModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<UpdateBankDetailModel?> getUpdateBankDetails(
    userId, bankNo, accountNo, bandCode) async {
  var headers = {'Cookie': 'ci_session=o939pk13gr3sn6bipbs6bb6grm09jg8g'};
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          baseUrl +'update_bank_details'));
  request.fields.addAll({
    'user_id': '$userId',
    'bank_name': '$bankNo',
    'account_number': '$accountNo',
    'bank_code': '$bandCode'
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // print(await response.stream.bytesToString());
    final str = await response.stream.bytesToString();
    return UpdateBankDetailModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetDriverDeModel?> getDriverDetails(userId) async {
  var headers = {'Cookie': 'ci_session=o939pk13gr3sn6bipbs6bb6grm09jg8g'};
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          baseUrl +'get_driver_details'));
  request.fields.addAll({'user_id': '$userId'});

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // print(await response.stream.bytesToString());
    final str = await response.stream.bytesToString();
    return GetDriverDeModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetCabsModel?> getCabs() async {
  var headers = {'Cookie': 'ci_session=6hr3oo59i3sgfdhslfth55q0kecpdm0k'};
  var request = http.Request(
      'GET',
      Uri.parse(
          baseUrl+'get_cabs'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // print(await response.stream.bytesToString());
    final str = await response.stream.bytesToString();
    return GetCabsModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetDataModel?> getModel(cabId) async {
  var headers = {'Cookie': 'ci_session=6hr3oo59i3sgfdhslfth55q0kecpdm0k'};
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          baseUrl + 'get_model'));
  request.fields.addAll({'cab_id': '$cabId'});

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // print(await response.stream.bytesToString());
    final str = await response.stream.bytesToString();
    return GetDataModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}
