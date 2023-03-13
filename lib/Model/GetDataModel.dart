import 'dart:convert';
/// status : true
/// message : "Get car detail"
/// data : [{"id":"1","car_type_id":"14","name":"","car_image":"https://alphawizztest.tk/Alpha_Yatri/assets/upload/car/1649831126.jpg","car_model":" Mahindra_model","status":"1"}]

GetDataModel getDataModelFromJson(String str) => GetDataModel.fromJson(json.decode(str));
String getDataModelToJson(GetDataModel data) => json.encode(data.toJson());
class GetDataModel {
  GetDataModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetDataModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
GetDataModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetDataModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// car_type_id : "14"
/// name : ""
/// car_image : "https://alphawizztest.tk/Alpha_Yatri/assets/upload/car/1649831126.jpg"
/// car_model : " Mahindra_model"
/// status : "1"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? carTypeId, 
      String? name, 
      String? carImage, 
      String? carModel, 
      String? status,}){
    _id = id;
    _carTypeId = carTypeId;
    _name = name;
    _carImage = carImage;
    _carModel = carModel;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _carTypeId = json['car_type_id'];
    _name = json['name'];
    _carImage = json['car_image'];
    _carModel = json['car_model'];
    _status = json['status'];
  }
  String? _id;
  String? _carTypeId;
  String? _name;
  String? _carImage;
  String? _carModel;
  String? _status;
Data copyWith({  String? id,
  String? carTypeId,
  String? name,
  String? carImage,
  String? carModel,
  String? status,
}) => Data(  id: id ?? _id,
  carTypeId: carTypeId ?? _carTypeId,
  name: name ?? _name,
  carImage: carImage ?? _carImage,
  carModel: carModel ?? _carModel,
  status: status ?? _status,
);
  String? get id => _id;
  String? get carTypeId => _carTypeId;
  String? get name => _name;
  String? get carImage => _carImage;
  String? get carModel => _carModel;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['car_type_id'] = _carTypeId;
    map['name'] = _name;
    map['car_image'] = _carImage;
    map['car_model'] = _carModel;
    map['status'] = _status;
    return map;
  }

}