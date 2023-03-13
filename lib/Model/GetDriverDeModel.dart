import 'dart:convert';
/// status : true
/// message : "Get profile detail"
/// data : {"id":"367","name":null,"user_name":"asdfsdaf","password":null,"phone":"454564561","address":null,"email":"asdfsda1@gmail.com","license_no":null,"car_type_id":null,"car_type":"sudo","car_no":"sadf26456","gender":null,"dob":null,"anniversary_date":null,"wallet_amount":"0","active_id":null,"user_status":null,"type":null,"rating":null,"latitude":null,"longitude":null,"timetype":null,"preffered_location":null,"device_id":"","permit_no":null,"insurance_no":null,"is_verified":"0","is_active":"0","is_block":"0","driving_licence_no":"download6.jpg","car_model":"asdf4545","otp":"0","bank_name":"dafsda","account_number":"878787878787","bank_code":"878787878"}

GetDriverDeModel getDriverDeModelFromJson(String str) => GetDriverDeModel.fromJson(json.decode(str));
String getDriverDeModelToJson(GetDriverDeModel data) => json.encode(data.toJson());
class GetDriverDeModel {
  GetDriverDeModel({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetDriverDeModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
GetDriverDeModel copyWith({  bool? status,
  String? message,
  Data? data,
}) => GetDriverDeModel(  status: status ?? _status,
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

/// id : "367"
/// name : null
/// user_name : "asdfsdaf"
/// password : null
/// phone : "454564561"
/// address : null
/// email : "asdfsda1@gmail.com"
/// license_no : null
/// car_type_id : null
/// car_type : "sudo"
/// car_no : "sadf26456"
/// gender : null
/// dob : null
/// anniversary_date : null
/// wallet_amount : "0"
/// active_id : null
/// user_status : null
/// type : null
/// rating : null
/// latitude : null
/// longitude : null
/// timetype : null
/// preffered_location : null
/// device_id : ""
/// permit_no : null
/// insurance_no : null
/// is_verified : "0"
/// is_active : "0"
/// is_block : "0"
/// driving_licence_no : "download6.jpg"
/// car_model : "asdf4545"
/// otp : "0"
/// bank_name : "dafsda"
/// account_number : "878787878787"
/// bank_code : "878787878"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      dynamic name, 
      String? userName, 
      dynamic password, 
      String? phone, 
      dynamic address, 
      String? email, 
      dynamic licenseNo, 
      dynamic carTypeId, 
      String? carType, 
      String? carNo, 
      dynamic gender, 
      dynamic dob, 
      dynamic anniversaryDate, 
      String? walletAmount, 
      dynamic activeId, 
      dynamic userStatus, 
      dynamic type, 
      dynamic rating, 
      dynamic latitude, 
      dynamic longitude, 
      dynamic timetype, 
      dynamic prefferedLocation, 
      String? deviceId, 
      dynamic permitNo, 
      dynamic insuranceNo, 
      String? isVerified, 
      String? isActive, 
      String? isBlock, 
      String? drivingLicenceNo, 
      String? carModel, 
      String? otp, 
      String? bankName, 
      String? accountNumber, 
      String? bankCode,}){
    _id = id;
    _name = name;
    _userName = userName;
    _password = password;
    _phone = phone;
    _address = address;
    _email = email;
    _licenseNo = licenseNo;
    _carTypeId = carTypeId;
    _carType = carType;
    _carNo = carNo;
    _gender = gender;
    _dob = dob;
    _anniversaryDate = anniversaryDate;
    _walletAmount = walletAmount;
    _activeId = activeId;
    _userStatus = userStatus;
    _type = type;
    _rating = rating;
    _latitude = latitude;
    _longitude = longitude;
    _timetype = timetype;
    _prefferedLocation = prefferedLocation;
    _deviceId = deviceId;
    _permitNo = permitNo;
    _insuranceNo = insuranceNo;
    _isVerified = isVerified;
    _isActive = isActive;
    _isBlock = isBlock;
    _drivingLicenceNo = drivingLicenceNo;
    _carModel = carModel;
    _otp = otp;
    _bankName = bankName;
    _accountNumber = accountNumber;
    _bankCode = bankCode;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _userName = json['user_name'];
    _password = json['password'];
    _phone = json['phone'];
    _address = json['address'];
    _email = json['email'];
    _licenseNo = json['license_no'];
    _carTypeId = json['car_type_id'];
    _carType = json['car_type'];
    _carNo = json['car_no'];
    _gender = json['gender'];
    _dob = json['dob'];
    _anniversaryDate = json['anniversary_date'];
    _walletAmount = json['wallet_amount'];
    _activeId = json['active_id'];
    _userStatus = json['user_status'];
    _type = json['type'];
    _rating = json['rating'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _timetype = json['timetype'];
    _prefferedLocation = json['preffered_location'];
    _deviceId = json['device_id'];
    _permitNo = json['permit_no'];
    _insuranceNo = json['insurance_no'];
    _isVerified = json['is_verified'];
    _isActive = json['is_active'];
    _isBlock = json['is_block'];
    _drivingLicenceNo = json['driving_licence_no'];
    _carModel = json['car_model'];
    _otp = json['otp'];
    _bankName = json['bank_name'];
    _accountNumber = json['account_number'];
    _bankCode = json['bank_code'];
  }
  String? _id;
  dynamic _name;
  String? _userName;
  dynamic _password;
  String? _phone;
  dynamic _address;
  String? _email;
  dynamic _licenseNo;
  dynamic _carTypeId;
  String? _carType;
  String? _carNo;
  dynamic _gender;
  dynamic _dob;
  dynamic _anniversaryDate;
  String? _walletAmount;
  dynamic _activeId;
  dynamic _userStatus;
  dynamic _type;
  dynamic _rating;
  dynamic _latitude;
  dynamic _longitude;
  dynamic _timetype;
  dynamic _prefferedLocation;
  String? _deviceId;
  dynamic _permitNo;
  dynamic _insuranceNo;
  String? _isVerified;
  String? _isActive;
  String? _isBlock;
  String? _drivingLicenceNo;
  String? _carModel;
  String? _otp;
  String? _bankName;
  String? _accountNumber;
  String? _bankCode;
Data copyWith({  String? id,
  dynamic name,
  String? userName,
  dynamic password,
  String? phone,
  dynamic address,
  String? email,
  dynamic licenseNo,
  dynamic carTypeId,
  String? carType,
  String? carNo,
  dynamic gender,
  dynamic dob,
  dynamic anniversaryDate,
  String? walletAmount,
  dynamic activeId,
  dynamic userStatus,
  dynamic type,
  dynamic rating,
  dynamic latitude,
  dynamic longitude,
  dynamic timetype,
  dynamic prefferedLocation,
  String? deviceId,
  dynamic permitNo,
  dynamic insuranceNo,
  String? isVerified,
  String? isActive,
  String? isBlock,
  String? drivingLicenceNo,
  String? carModel,
  String? otp,
  String? bankName,
  String? accountNumber,
  String? bankCode,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  userName: userName ?? _userName,
  password: password ?? _password,
  phone: phone ?? _phone,
  address: address ?? _address,
  email: email ?? _email,
  licenseNo: licenseNo ?? _licenseNo,
  carTypeId: carTypeId ?? _carTypeId,
  carType: carType ?? _carType,
  carNo: carNo ?? _carNo,
  gender: gender ?? _gender,
  dob: dob ?? _dob,
  anniversaryDate: anniversaryDate ?? _anniversaryDate,
  walletAmount: walletAmount ?? _walletAmount,
  activeId: activeId ?? _activeId,
  userStatus: userStatus ?? _userStatus,
  type: type ?? _type,
  rating: rating ?? _rating,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  timetype: timetype ?? _timetype,
  prefferedLocation: prefferedLocation ?? _prefferedLocation,
  deviceId: deviceId ?? _deviceId,
  permitNo: permitNo ?? _permitNo,
  insuranceNo: insuranceNo ?? _insuranceNo,
  isVerified: isVerified ?? _isVerified,
  isActive: isActive ?? _isActive,
  isBlock: isBlock ?? _isBlock,
  drivingLicenceNo: drivingLicenceNo ?? _drivingLicenceNo,
  carModel: carModel ?? _carModel,
  otp: otp ?? _otp,
  bankName: bankName ?? _bankName,
  accountNumber: accountNumber ?? _accountNumber,
  bankCode: bankCode ?? _bankCode,
);
  String? get id => _id;
  dynamic get name => _name;
  String? get userName => _userName;
  dynamic get password => _password;
  String? get phone => _phone;
  dynamic get address => _address;
  String? get email => _email;
  dynamic get licenseNo => _licenseNo;
  dynamic get carTypeId => _carTypeId;
  String? get carType => _carType;
  String? get carNo => _carNo;
  dynamic get gender => _gender;
  dynamic get dob => _dob;
  dynamic get anniversaryDate => _anniversaryDate;
  String? get walletAmount => _walletAmount;
  dynamic get activeId => _activeId;
  dynamic get userStatus => _userStatus;
  dynamic get type => _type;
  dynamic get rating => _rating;
  dynamic get latitude => _latitude;
  dynamic get longitude => _longitude;
  dynamic get timetype => _timetype;
  dynamic get prefferedLocation => _prefferedLocation;
  String? get deviceId => _deviceId;
  dynamic get permitNo => _permitNo;
  dynamic get insuranceNo => _insuranceNo;
  String? get isVerified => _isVerified;
  String? get isActive => _isActive;
  String? get isBlock => _isBlock;
  String? get drivingLicenceNo => _drivingLicenceNo;
  String? get carModel => _carModel;
  String? get otp => _otp;
  String? get bankName => _bankName;
  String? get accountNumber => _accountNumber;
  String? get bankCode => _bankCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['user_name'] = _userName;
    map['password'] = _password;
    map['phone'] = _phone;
    map['address'] = _address;
    map['email'] = _email;
    map['license_no'] = _licenseNo;
    map['car_type_id'] = _carTypeId;
    map['car_type'] = _carType;
    map['car_no'] = _carNo;
    map['gender'] = _gender;
    map['dob'] = _dob;
    map['anniversary_date'] = _anniversaryDate;
    map['wallet_amount'] = _walletAmount;
    map['active_id'] = _activeId;
    map['user_status'] = _userStatus;
    map['type'] = _type;
    map['rating'] = _rating;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['timetype'] = _timetype;
    map['preffered_location'] = _prefferedLocation;
    map['device_id'] = _deviceId;
    map['permit_no'] = _permitNo;
    map['insurance_no'] = _insuranceNo;
    map['is_verified'] = _isVerified;
    map['is_active'] = _isActive;
    map['is_block'] = _isBlock;
    map['driving_licence_no'] = _drivingLicenceNo;
    map['car_model'] = _carModel;
    map['otp'] = _otp;
    map['bank_name'] = _bankName;
    map['account_number'] = _accountNumber;
    map['bank_code'] = _bankCode;
    return map;
  }

}