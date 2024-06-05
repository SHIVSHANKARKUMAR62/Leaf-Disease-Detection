import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather_model.dart';


class Repo {
  getWeather(String? city) async {
    var url =
        "";

    final res = await http.get(Uri.parse(url));

    var resBody = res.body;
    print(resBody);
    try {
      if (res.statusCode == 200) {
        return WeatherModel.fromJson(json.decode(resBody));
      }
    } catch (e) {
      throw Exception();
    }
  }
}