import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final data;
  LocationScreen(this.data);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  var temp;
  var cityName;
  var weatherIcon;
  var weatherMessage;
  @override
  void initState() {
    super.initState();
    var data = widget.data;
    updateWeatherData(data);
  }

  void updateWeatherData(weatherData) {
    setState(() {
      if (weatherData == Null) {
        temp = '??';
        cityName = '??';
        weatherIcon = '??';
        weatherMessage = '??';
        return;
      }
      temp = weatherData['main']['temp'].toInt();
      cityName = weatherData['name'];
      weatherIcon =
          weatherModel.getWeatherIcon(weatherData['weather'][0]['id']);
      weatherMessage = weatherModel.getMessage(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var data = await weatherModel.getLocationWeather();
                      updateWeatherData(data);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      if (cityName != Null) {
                        var data = await weatherModel.getCityWeather(cityName);
                        updateWeatherData(data);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                child: Text(
                  //"$weatherMessage in "
                  "$cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
