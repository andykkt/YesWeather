import 'package:flutter/material.dart';
import 'package:yesweather/Common/TextStyle.dart';

class WeatherIconTempView extends StatelessWidget {
  final String iconName;
  final String temperture;
  final String weatherName;

  WeatherIconTempView({
    Key key,
    @required this.iconName,
    @required this.temperture,
    @required this.weatherName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'resource/images/weather/$iconName.png',
              width: 100,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(width: 32),
            Text(
              "$temperture°",
              style: TempertureTextStyle.headline4(context),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          "$weatherName",
          style: LabelTextStyle.bodyText1(context),
        ),
      ],
    );
  }
}
