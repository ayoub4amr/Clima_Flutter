import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '3cde0bc3851d617bf24e36a4e21d97d8';

class WeatherModel {
  Future getCityWeather(cityName) async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric");
    Data locationData = Data(url);
    var data = await locationData.getData();
    return data;
  }

  Future getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric");
    Data locationData = Data(url);
    var data = await locationData.getData();
    return data;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
