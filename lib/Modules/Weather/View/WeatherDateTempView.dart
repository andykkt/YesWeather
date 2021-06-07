import 'package:flutter/material.dart';
import 'package:yesweather/Common/TextStyle.dart';

class WeatherDateTempView extends StatelessWidget {
  final String date;
  final double minTemperature;
  final double maxTemperature;

  WeatherDateTempView({
    Key key,
    @required this.date,
    @required this.minTemperature,
    @required this.maxTemperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date,
                style: LabelTextStyle.bodyText1(context),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Text(
                    "min $minTemperature°",
                    style: LabelTextStyle.bodyText2(context),
                  ),
                  Text(
                    " / ",
                    style: LabelTextStyle.bodyText1(context),
                  ),
                  Text(
                    "max $maxTemperature°",
                    style: LabelTextStyle.bodyText1(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
