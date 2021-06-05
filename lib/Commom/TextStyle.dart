import 'package:flutter/material.dart';

class TitleTextStyle {
  static TextStyle headline4(BuildContext context) {
    return Theme.of(context).textTheme.headline4.copyWith(
          fontFamily: 'MarkPro',
          fontWeight: FontWeight.bold,
          fontSize: 28.0,
          color: Colors.white,
        );
  }
}

class LabelTextStyle {
  static TextStyle bodyText1(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
          fontFamily: 'MarkPro',
          fontSize: 16.0,
          color: Colors.white,
        );
  }

  static TextStyle bodyText2(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
          fontFamily: 'MarkPro',
          fontSize: 16.0,
          color: Colors.black54,
        );
  }
}

class TempertureTextStyle {
  static TextStyle headline4(BuildContext context) {
    return Theme.of(context).textTheme.headline4.copyWith(
          fontFamily: 'MarkPro',
          fontWeight: FontWeight.bold,
          fontSize: 50.0,
          color: Colors.white,
        );
  }
}
