import 'dart:convert';

/// status : true
/// message : "User added successfully "
/// data : 395
/// otp : 8219

GetSignInModel getSignInModelFromJson(String str) =>
    GetSignInModel.fromJson(json.decode(str));

String getSignInModelToJson(GetSignInModel data) => json.encode(data.toJson());

class GetSignInModel {
  GetSignInModel({
    bool? status,
    String? message,
    String? data,
    String? otp,
    String? phone,
  }) {
    _status = status;
    _message = message;
    _data = data;
    _otp = otp;
    _phone = phone;
  }

  GetSignInModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'];
    _otp = json['otp'];
    _phone = json['phone'];
  }

  bool? _status;
  String? _message;
  String? _data;
  String? _otp;
  String? _phone;

  GetSignInModel copyWith({
    bool? status,
    String? message,
    String? data,
    String? otp,
    String? phone,
  }) =>
      GetSignInModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
        otp: otp ?? _otp,
        phone: phone ?? _phone,
      );

  bool? get status => _status;

  String? get message => _message;

  String? get data => _data;

  String? get otp => _otp;

  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data;
    map['otp'] = _otp;
    map['phone'] = _phone;
    return map;
  }
}
