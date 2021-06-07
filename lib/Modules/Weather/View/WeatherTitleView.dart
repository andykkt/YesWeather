import 'package:flutter/material.dart';
import 'package:yesweather/Common/StyledButton.dart';
import 'package:yesweather/Common/TextStyle.dart';

class WeatherTitleView extends StatelessWidget {
  final String cityName;
  final String countryName;
  final VoidCallback onDismiss;

  WeatherTitleView(
      {Key key,
      @required this.cityName,
      @required this.countryName,
      @required this.onDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: StyledButton(
            icon: Icons.close,
            onPressed: () {
              onDismiss();
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  cityName,
                  style: TitleTextStyle.headline4(context),
                ),
                SizedBox(height: 8),
                Text(
                  countryName,
                  style: LabelTextStyle.bodyText1(context),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
