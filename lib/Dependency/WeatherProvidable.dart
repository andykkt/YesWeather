import 'package:yesweather/Modules/Weather/Model/WeatherModel.dart';
import 'dart:async';

abstract class WeatherProvidable {
  Future<WeatherModel> getWeather({String latitude, String longitude});
}
