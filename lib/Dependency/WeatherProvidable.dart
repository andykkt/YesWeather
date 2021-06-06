import 'package:yesweather/modules/weather/model/WeatherModel.dart';
import 'dart:async';

abstract class WeatherProvidable {
  Future<WeatherModel> getWeather({String latitude, String longitude});
}
