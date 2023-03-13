import 'dart:convert';
/// status : true
/// message : "updated bank Details successfully"
/// data : {"user_name":"rahulraj","email":"raj@gmail.com","phone":"9753123456","car_type":"mini","car_model":"freshly","car_no":"202045"}

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));
String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());
class SignUpModel {
  SignUpModel({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  SignUpModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
SignUpModel copyWith({  bool? status,
  String? message,
  Data? data,
}) => SignUpModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// user_name : "rahulraj"
/// email : "raj@gmail.com"
/// phone : "9753123456"
/// car_type : "mini"
/// car_model : "freshly"
/// car_no : "202045"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? userName, 
      String? email, 
      String? phone, 
      String? carType, 
      String? carModel, 
      String? carNo,}){
    _userName = userName;
    _email = email;
    _phone = phone;
    _carType = carType;
    _carModel = carModel;
    _carNo = carNo;
}

  Data.fromJson(dynamic json) {
    _userName = json['user_name'];
    _email = json['email'];
    _phone = json['phone'];
    _carType = json['car_type'];
    _carModel = json['car_model'];
    _carNo = json['car_no'];
  }
  String? _userName;
  String? _email;
  String? _phone;
  String? _carType;
  String? _carModel;
  String? _carNo;
Data copyWith({  String? userName,
  String? email,
  String? phone,
  String? carType,
  String? carModel,
  String? carNo,
}) => Data(  userName: userName ?? _userName,
  email: email ?? _email,
  phone: phone ?? _phone,
  carType: carType ?? _carType,
  carModel: carModel ?? _carModel,
  carNo: carNo ?? _carNo,
);
  String? get userName => _userName;
  String? get email => _email;
  String? get phone => _phone;
  String? get carType => _carType;
  String? get carModel => _carModel;
  String? get carNo => _carNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = _userName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['car_type'] = _carType;
    map['car_model'] = _carModel;
    map['car_no'] = _carNo;
    return map;
  }

}