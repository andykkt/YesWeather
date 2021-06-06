import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yesweather/app/DIContainer.dart';
import 'package:yesweather/dependency/LocationProvidable.dart';
import 'package:yesweather/modules/root/model/LocationPosition.dart';

enum RootViewModelState { none, loading, loaded, error }

class RootViewModel {
  // Private Members

  LocationPosition _currentLocationPosition;
  LocationProvidable _locationProvider;
  var _statusController = StreamController<RootViewModelState>.broadcast();

  // Constructor

  factory RootViewModel(DIContainer container) {
    return RootViewModel._internal(
      locationProvider: container.getLocationProvider(),
    );
  }

  RootViewModel._internal({
    @required LocationProvidable locationProvider,
  }) {
    _locationProvider = locationProvider;
  }

  // Public Functions

  Stream<RootViewModelState> listenToState() => _statusController.stream;

  void fetchLocation() {
    _statusController.add(RootViewModelState.loading);
    _locationProvider.onLocationChange().listen((locationPosition) {
      _currentLocationPosition = locationPosition;
      _statusController.add(RootViewModelState.loaded);
    });
  }

  getCurrentLocationPosition() => _currentLocationPosition;
}
