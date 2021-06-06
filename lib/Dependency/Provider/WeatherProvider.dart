import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:yesweather/modules/weather/model/WeatherModel.dart';
import 'package:yesweather/dependency/WeatherProvidable.dart';

class WeatherProvider extends WeatherProvidable {
  static const String APPID = "<APIKEY>";

  Future<WeatherModel> getWeather({String latitude, String longitude}) async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$APPID&units=metric'),
    );

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      var model = WeatherModel.fromJson(result);
      return model;
    } else {
      throw Exception('Failed to load Weather Information');
    }
  }
}
