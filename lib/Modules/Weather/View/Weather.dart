import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yesweather/app/AppRoutes.dart';
import 'package:yesweather/app/DIContainer.dart';
import 'package:yesweather/Modules/Weather/Viewmodel/WeatherViewModel.dart';
import 'package:yesweather/Modules/Weather/View/WeatherTitleView.dart';
import 'package:yesweather/Modules/Weather/View/WeatherIconTempView.dart';
import 'package:yesweather/Modules/Weather/View/WeatherDateTempView.dart';

class Weather extends StatelessWidget {
  final BuildContext context;
  Weather(this.context);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
      home: WeatherView(this.context),
      onGenerateRoute: AppRoutes().getRoutes,
    );
  }
}

class WeatherView extends StatefulWidget {
  final BuildContext context;
  WeatherView(this.context);

  @override
  State<StatefulWidget> createState() => WeatherViewState();
}

class WeatherViewState extends State<WeatherView> {
  // Private Members

  WeatherViewModel _viewModel;
  WeatherViewModelState _state;

  // Constructor

  @override
  void initState() {
    // Setup dependencies
    _viewModel = WeatherViewModel(DIContainer());

    super.initState();

    _subscribeToViewModelStatus();
  }

  void _subscribeToViewModelStatus() {
    _viewModel.listenToState().listen((state) {
      setState(() {
        print("[WeatherView: subscribeToViewModelStatus] set state: $state");
        _state = state;
      });
    });

    _viewModel.fetchWeather();
  }

  // Build

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Theme.of(context).primaryColorDark,
    ));
    switch (_state) {
      case WeatherViewModelState.loaded:
        return loadedView();
      case WeatherViewModelState.loading:
        return loadingView();
      case WeatherViewModelState.error:
        return errorView();
      default:
        return idleView();
    }
  }

  loadedView() {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("resource/images/background.png"),
                fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  WeatherTitleView(
                      cityName: _viewModel.cityName(),
                      countryName: _viewModel.countryName(),
                      onDismiss: () {
                        print('[Weather] onDismiss');
                        Navigator.pop(widget.context);
                      }),
                  SizedBox(height: 24),
                  WeatherIconTempView(
                    iconName: _viewModel.getWeather().weather[0].icon,
                    temperture: _viewModel.getWeather().main.temp.toString(),
                    weatherName: _viewModel.getWeather().weather[0].main,
                  ),
                  SizedBox(height: 24),
                  WeatherDateTempView(
                    date: _viewModel.dateString(),
                    minTemperature: _viewModel.getWeather().main.tempMin,
                    maxTemperature: _viewModel.getWeather().main.tempMax,
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loadingView() {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("resource/images/background.png"),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [CircularProgressIndicator()])
              ],
            ),
          ),
        ),
      ),
    );
  }

  errorView() {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("resource/images/background.png"),
              fit: BoxFit.cover),
        ),
        child: Text('Error fetch weather'),
      ),
    );
  }

  idleView() {
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
}
