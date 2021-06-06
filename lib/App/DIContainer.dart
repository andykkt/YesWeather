import 'package:flutter/material.dart';
import 'package:yesweather/dependency/LocationProvidable.dart';
import 'package:yesweather/dependency/WeatherProvidable.dart';
import 'package:yesweather/dependency/provider/LocationProvider.dart';
import 'package:yesweather/dependency/provider/WeatherProvider.dart';

class DIContainer {
  WeatherProvidable _weatherProvider;
  LocationProvidable _locationProvider;

  static DIContainer _instance;

  factory DIContainer() {
    _instance ??= DIContainer._internal(
      weatherProvider: WeatherProvider(),
      locationProvider: LocationProvider(),
    );
    return _instance;
  }

  DIContainer._internal({
    @required WeatherProvidable weatherProvider,
    @required LocationProvidable locationProvider,
  }) {
    _weatherProvider = weatherProvider;
    _locationProvider = locationProvider;
  }

  WeatherProvidable getWeatherProvider() => _weatherProvider;
  LocationProvidable getLocationProvider() => _locationProvider;
}
