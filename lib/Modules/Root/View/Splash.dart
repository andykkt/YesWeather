import 'package:flutter/material.dart';
import 'package:yesweather/app/AppRoutes.dart';
import 'dart:async';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
      home: SplashView(),
      onGenerateRoute: AppRoutes().getRoutes,
    );
  }
}

class SplashView extends StatefulWidget {
  SplashView({Key key}) : super(key: key);

  @override
  State<SplashView> createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    _startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("resource/images/background.png"),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  // Private Functions
  _startTimeout() async {
    return Timer(const Duration(seconds: 2), _handleTimeout);
  }

  void _handleTimeout() async {
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.APP_ROUTE_ROOT,
    );
  }
}
