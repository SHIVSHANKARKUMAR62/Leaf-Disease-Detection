
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../serves/api_services.dart';

class MainController extends GetxController {
  @override
  void onInit() async {
    await getUserLocation();
    super.onInit();
  }

  dynamic currentWeatherData;
  dynamic hourlyWeatherData;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  var isloaded = false.obs;

  getUserLocation() async {
    bool isLocationEnabled;
    LocationPermission userPermission;

    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return Future.error("Location is not enabled");
    }

    userPermission = await Geolocator.checkPermission();
    if (userPermission == LocationPermission.deniedForever) {
      return Future.error("Permission is denied forever");
    } else if (userPermission == LocationPermission.denied) {
      userPermission = await Geolocator.requestPermission();
      if (userPermission == LocationPermission.denied) {
        return Future.error("Permission is denied");
      }
    }else {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high).then((value) {
        latitude.value = value.latitude;
        longitude.value = value.longitude;
        currentWeatherData = getCurrentWeather(latitude.value, longitude.value);
        hourlyWeatherData = getHourlyWeather(latitude.value, longitude.value);
        update();
        isloaded.value = true;
      });
    }
  }
}