import 'package:yesweather/modules/root/model/LocationPosition.dart';

abstract class LocationProvidable {
  Stream<LocationPosition> onLocationChange();
  bool hasPermission();
  LocationPosition getCurrentLocationPosition();
}