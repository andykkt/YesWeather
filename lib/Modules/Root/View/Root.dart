import 'package:flutter/material.dart';
import 'package:yesweather/Modules/Root/ViewModel/RootViewModel.dart';
import 'package:yesweather/app/AppRoutes.dart';
import 'package:yesweather/app/DIContainer.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
      home: RootView(),
      onGenerateRoute: AppRoutes().getRoutes,
    );
  }
}

class RootView extends StatefulWidget {
  RootView({Key key}) : super(key: key);

  @override
  State<RootView> createState() => RootViewState();
}

class RootViewState extends State<RootView> {
  // Private Members

  RootViewModel _viewModel;
  RootViewModelState _state;

  // Constructor

  @override
  void initState() {
    // Setup dependencies
    _viewModel = RootViewModel(DIContainer());
    super.initState();
    _subscribeToViewModelState();
  }

  void _subscribeToViewModelState() {
    _viewModel.listenToState().listen((state) {
      setState(() {
        _state = state;
      });
    });

    _viewModel.fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    switch (_state) {
      case RootViewModelState.loaded:
        return _loadedView();
      case RootViewModelState.loading:
        return _loadingView();
      case RootViewModelState.error:
        return _errorView();
      default:
        return _idleView();
    }
  }

  _loadedView() {
    var currentLocationPosition = _viewModel.getCurrentLocationPosition();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.APP_ROUTE_WEATHER,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Get Weather'),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('User location: '),
                      Text(
                          'Latitude: (${currentLocationPosition.latitude.toString()})'),
                      Text(
                          'Longitude: (${currentLocationPosition.longitude.toString()})'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _idleView() {
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

  _loadingView() {
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
                    children: [
                      CircularProgressIndicator(
                        semanticsLabel: 'Getting Location...',
                      )
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  _errorView() {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 32.0,
                ),
                Text('Error fetching location'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
