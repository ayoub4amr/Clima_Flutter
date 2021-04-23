import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getPositionData() async {
    WeatherModel weatherModel = WeatherModel();
    var data = await weatherModel.getLocationWeather();

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationScreen(data)));
  }

  @override
  void initState() {
    super.initState();
    getPositionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
