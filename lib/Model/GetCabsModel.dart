import 'dart:convert';
/// status : true
/// message : "Get car detail"
/// data : [{"id":"1","car_type":"Sedan","car_image":"https://alphawizztest.tk/Alpha_Yatri/assets/upload/car/1649831126.jpg","status":"Active"},{"id":"3","car_type":"Hatchback","car_image":"https://gnhub.net/zappy/assets/upload/car/1574753851.png","status":"Inactive"},{"id":"4","car_type":"Nano","car_image":"https://gnhub.net/zappy/assets/upload/car/1574753806.png","status":"Inactive"},{"id":"5","car_type":"SUV","car_image":"https://alphawizztest.tk/Alpha_Yatri/assets/upload/car/1649831059.jpg","status":"Inactive"},{"id":"7","car_type":"Mini","car_image":"https://gnhub.net/zappy/assets/upload/car/1574753897.png","status":"Active"},{"id":"9","car_type":"Auto","car_image":"https://gnhub.net/zappy/assets/upload/car/1574753876.png","status":"Inactive"},{"id":"10","car_type":"Innova","car_image":"https://alphawizztest.tk/Alpha_Yatri/assets/upload/car/1649826518.jpg","status":"Inactive"},{"id":"11","car_type":"Ertiga","car_image":"https://alphawizztest.tk/Alpha_Yatri/assets/upload/car/1649830296.jpg","status":"Active"},{"id":"12","car_type":"Toyota","car_image":"https://alphawizztest.tk/Alpha_Yatri/assets/upload/car/1649830398.jpg","status":"Inactive"},{"id":"13","car_type":"Scorpio","car_image":"https://alphawizztest.tk/Alpha_Yatri/assets/upload/car/1649830504.jpg","status":"Active"},{"id":"14","car_type":" Mahindra TUV","car_image":"https://alphawizztest.tk/Alpha_Yatri/assets/upload/car/1649830661.jpg","status":"Active"},{"id":"15","car_type":"Volvo","car_image":"https://productsalphawizz.com/taxi/assets/upload/car/1650377819.png","status":"Inactive"},{"id":"16","car_type":"Volvo1","car_image":"https://productsalphawizz.com/taxi/assets/upload/car/1650378132.png","status":"Active"},{"id":"17","car_type":"nhghhgh","car_image":"https://productsalphawizz.com/taxi/assets/upload/car/1650378157.png","status":"Active"},{"id":"18","car_type":"abc","car_image":"https://productsalphawizz.com/taxi/assets/upload/car/1650521582.png","status":"Inactive"}]

GetCabsModel getCabsModelFromJson(String str) => GetCabsModel.fromJson(json.decode(str));
String getCabsModelToJson(GetCabsModel data) => json.encode(data.toJson());
class GetCabsModel {
  GetCabsModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetCabsModel.fromJson(dynamic json) {
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
GetCabsModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetCabsModel(  status: status ?? _status,
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
/// car_type : "Sedan"
/// car_image : "https://alphawizztest.tk/Alpha_Yatri/assets/upload/car/1649831126.jpg"
/// status : "Active"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? carType, 
      String? carImage, 
      String? status,}){
    _id = id;
    _carType = carType;
    _carImage = carImage;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _carType = json['car_type'];
    _carImage = json['car_image'];
    _status = json['status'];
  }
  String? _id;
  String? _carType;
  String? _carImage;
  String? _status;
Data copyWith({  String? id,
  String? carType,
  String? carImage,
  String? status,
}) => Data(  id: id ?? _id,
  carType: carType ?? _carType,
  carImage: carImage ?? _carImage,
  status: status ?? _status,
);
  String? get id => _id;
  String? get carType => _carType;
  String? get carImage => _carImage;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['car_type'] = _carType;
    map['car_image'] = _carImage;
    map['status'] = _status;
    return map;
  }

}