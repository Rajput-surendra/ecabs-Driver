import 'dart:convert';
/// status : true
/// message : "updated bank Details successfully"
/// data : {"bank_name":"dafsda","account_number":"878787878787","bank_code":"878787878"}

UpdateBankDetailModel updateBankDetailModelFromJson(String str) => UpdateBankDetailModel.fromJson(json.decode(str));
String updateBankDetailModelToJson(UpdateBankDetailModel data) => json.encode(data.toJson());
class UpdateBankDetailModel {
  UpdateBankDetailModel({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  UpdateBankDetailModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
UpdateBankDetailModel copyWith({  bool? status,
  String? message,
  Data? data,
}) => UpdateBankDetailModel(  status: status ?? _status,
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

/// bank_name : "dafsda"
/// account_number : "878787878787"
/// bank_code : "878787878"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? bankName, 
      String? accountNumber, 
      String? bankCode,}){
    _bankName = bankName;
    _accountNumber = accountNumber;
    _bankCode = bankCode;
}

  Data.fromJson(dynamic json) {
    _bankName = json['bank_name'];
    _accountNumber = json['account_number'];
    _bankCode = json['bank_code'];
  }
  String? _bankName;
  String? _accountNumber;
  String? _bankCode;
Data copyWith({  String? bankName,
  String? accountNumber,
  String? bankCode,
}) => Data(  bankName: bankName ?? _bankName,
  accountNumber: accountNumber ?? _accountNumber,
  bankCode: bankCode ?? _bankCode,
);
  String? get bankName => _bankName;
  String? get accountNumber => _accountNumber;
  String? get bankCode => _bankCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bank_name'] = _bankName;
    map['account_number'] = _accountNumber;
    map['bank_code'] = _bankCode;
    return map;
  }

}