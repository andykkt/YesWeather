import 'dart:async';
import 'package:location/location.dart';
import 'package:yesweather/dependency/LocationProvidable.dart';
import 'package:yesweather/modules/root/model/LocationPosition.dart';

class LocationProvider extends LocationProvidable {
  // Private Members

  Location _location = new Location();
  bool _permission = false;
  LocationPosition _currentLocationPosition;
  var _currentLocationStream = StreamController<LocationPosition>.broadcast();

  // Constructor

  LocationProvider() {}

  void initLocationStream() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Check location service
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        _currentLocationStream.addError('Failed to request location service');
        return;
      }
    }

    // Check the permission
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        _currentLocationStream.addError('Failed to get permission');
        return;
      }
    }

    _location.onLocationChanged.listen((userLocation) {
      var newLocation = LocationPosition(
          latitude: userLocation.latitude, longitude: userLocation.longitude);
      if (newLocation.latitude != (_currentLocationPosition?.latitude ?? 0) ||
          newLocation.longitude != (_currentLocationPosition?.longitude ?? 0)) {
        _currentLocationPosition = newLocation;
        _currentLocationStream.add(_currentLocationPosition);
      }
    });
  }

  // Public Functions

  Stream<LocationPosition> onLocationChange() {
    return _currentLocationStream.stream;
  }

  LocationPosition getCurrentLocationPosition() => _currentLocationPosition;
  bool hasPermission() => _permission;
}
