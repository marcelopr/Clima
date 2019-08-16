import 'package:tempocerto/services/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = APIKEY;
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherData {
  Future<dynamic> getCityWeather(String cityName) async {
    try {
      var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
      //NetworkHelper networkHelper = NetworkHelper(url);

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data); //dart:convert import
        return decodedData;
      } else {
        return null;
        //return null so the ui can be updated with a message
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  //var weatherData = await networkHelper.getData();
  //return weatherData;
}
