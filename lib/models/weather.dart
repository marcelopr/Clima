import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Weather {
  Weather(
      {this.temp,
      this.tempMin,
      this.tempMax,
      this.humidity,
      this.description,
      this.city,
      this.condition});

  int temp;
  int tempMin;
  int tempMax;
  int humidity;
  int wind;
  String description;
  String city;
  int condition;

  String formatTemp(int temperature) {
    return temperature.toString() + 'º';
  }

  String formatWind() {
    return wind.toString() + ' Km/h';
  }

  String formatHumidity() {
    return humidity.toString() + '%';
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

  String getWeatherImage(int condition) {
    if (condition >= 200 && condition < 300) {
      return 'lib/assets/ic_thunder_storm.png';
    } else if (condition >= 300 && condition < 400) {
      return 'lib/assets/ic_rain.png';
    } else if (condition >= 500 && condition < 600) {
      return 'lib/assets/ic_rain.png';
    } else if (condition >= 600 && condition < 700) {
      return 'lib/assets/ic_snow.png';
    } else if (condition == 800) {
      return 'lib/assets/ic_sun.png';
    } else if (condition == 801 || condition == 802) {
      return 'lib/assets/ic_cloudy.png';
    } else if (condition > 802) {
      return 'lib/assets/ic_cloud.png';
    } else {
      return 'lib/assets/ic_cloud.png';
    }
  }
}
