import 'package:flutter/material.dart';
import 'package:yesweather/App/AppRoutes.dart';

class App extends StatelessWidget {
  // Singleton instance
  static final App _instance = App._internal();

  // Private Constructor
  App._internal();

  // App Factory Constructor
  factory App() => _instance;

  // Build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: getAppRoutes().getRoutes,
    );
  }

  // Get App Routes
  AppRoutes getAppRoutes() {
    return AppRoutes();
  }
}
