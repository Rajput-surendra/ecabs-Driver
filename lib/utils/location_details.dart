import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:qcabs_driver/utils/ApiBaseHelper.dart';
import 'package:qcabs_driver/utils/Session.dart';
import 'package:qcabs_driver/utils/common.dart';
import 'package:qcabs_driver/utils/constant.dart';

class GetLocation{
  LocationData? _currentPosition;
  late String _address = "";
  Location location1 = Location();
  String firstLocation = "",lat = "",lng = "";
  ValueChanged onResult;

  GetLocation(this.onResult);
  Future<void> getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location1.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location1.requestService();
      if (!_serviceEnabled) {
        print('ek');
        return;
      }
    }

    _permissionGranted = await location1.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location1.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('no');
        return;
      }
    }

    location1.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.latitude} : ${currentLocation.longitude}");
      _currentPosition = currentLocation;print(currentLocation.latitude);

      _getAddress(_currentPosition!.latitude,
          _currentPosition!.longitude)
          .then((value) {
        _address = "${value.first.addressLine}";
        firstLocation = value.first.subLocality.toString();
        print(_address);
        lat = _currentPosition!.latitude.toString();
        lng = _currentPosition!.longitude.toString();

        updateLocation();
        if(latitude!=value.first.coordinates.latitude){

          print("ok");
          onResult(value);
        }
        if(latitude == 0){
          latitude = _currentPosition!.latitude!;
          longitude = _currentPosition!.longitude!;
        }
      });
    });
  }
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  updateLocation() async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "user_id": curUserId,
          "lat": lat.toString(),
          "lang": lng.toString()
        };
        var response = await post(
            Uri.parse(baseUrl + "update_lat_lang_driver"), body: data);
      } on TimeoutException catch (_) {
      }
    } else {
    }
  }
  Future<List<Address>> _getAddress(double? lat, double? lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }


}