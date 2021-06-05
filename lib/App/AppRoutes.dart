import 'package:flutter/material.dart';
import 'package:yesweather/Modules/Root/View/Root.dart';
import 'package:yesweather/Modules/Root/View/Splash.dart';
import 'package:yesweather/Modules/Weather/View/Weather.dart';

class AppRoutes {
  static const String APP_ROUTE_ROOT = "/root";
  static const String APP_ROUTE_WEATHER = "/weather";

  Route getRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case APP_ROUTE_ROOT:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => Root(),
            fullscreenDialog: true,
          );
        }
      case APP_ROUTE_WEATHER:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => Weather(),
            fullscreenDialog: true,
          );
        }
      default:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => Splash(),
            fullscreenDialog: true,
          );
        }
    }
  }
}
