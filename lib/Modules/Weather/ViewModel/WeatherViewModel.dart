import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yesweather/app/DIContainer.dart';
import 'package:yesweather/dependency/LocationProvidable.dart';
import 'package:yesweather/dependency/WeatherProvidable.dart';
import 'package:yesweather/modules/weather/model/WeatherModel.dart';

enum WeatherViewModelState { none, loading, loaded, error }

class WeatherViewModel {
  // Private Members

  WeatherProvidable _weatherService;
  LocationProvidable _locationService;
  WeatherModel _weather;
  var _statusController = StreamController<WeatherViewModelState>.broadcast();

  // Constructors

  factory WeatherViewModel(DIContainer container) {
    return WeatherViewModel._internal(
      weatherService: container.getWeatherProvider(),
      locationService: container.getLocationProvider(),
    );
  }

  WeatherViewModel._internal({
    @required WeatherProvidable weatherService,
    @required LocationProvidable locationService,
  }) {
    _weatherService = weatherService;
    _locationService = locationService;
  }

  // Public Functions

  Stream<WeatherViewModelState> listenToState() => _statusController.stream;

  void fetchWeather() {
    _statusController.add(WeatherViewModelState.loading);
    var currentLocation = _locationService.getCurrentLocationPosition();
    _weatherService
        .getWeather(
      latitude: currentLocation.latitude.toString(),
      longitude: currentLocation.longitude.toString(),
    )
        .then(
      (weather) {
        print("[WeatherViewModel] weather: $weather");
        _weather = weather;
        _statusController.add(WeatherViewModelState.loaded);
      },
    );
  }

  WeatherModel getWeather() => _weather;

  String cityName() {
    return _weather.name;
  }

  String countryName() {
    return _weather.sys.country;
  }

  String dateString() {
    var fm = new DateFormat('MMMM dd, yyyy');
    return fm.format(
      new DateTime.fromMillisecondsSinceEpoch((_weather.dt * 1000),
          isUtc: true),
    );
  }
}
