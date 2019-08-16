import 'package:flutter/material.dart';
import 'package:tempocerto/models/weather.dart';
import 'package:tempocerto/services/weather_data.dart';
import 'package:tempocerto/widgets/weather_info_screen.dart';
import 'package:tempocerto/widgets/loading_screen.dart';
import 'package:tempocerto/widgets/message_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class CityScreen extends StatefulWidget {
  CityScreen({Key key}) : super(key: key);

  _CityScreencreateState() => _CityScreenState();

  @override
  State<StatefulWidget> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  WeatherData weatherData = WeatherData();
  Weather weather = Weather();
  Widget _body;
  int temp, tempMax, tempMin, humidity;
  String city = "";
  final myController = TextEditingController();
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  void getPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    city = sharedPreferences.getString('city') ?? "";
    getData();
  }

  void getData() async {
    _selectBody(LoadingWidget());

    if (city.isEmpty || city == null) {
      print('city empty');
      _selectBody(
        MessageScreen(
          message: 'Veja como está o tempo na cidade que desejar.',
          function: mostrarDialog,
        ),
      );
      return;
    }

    var data = await weatherData.getCityWeather(city);

    if (data == null) {
      _selectBody(
        MessageScreen(
          message: 'Local não encontrado =( \nTente novamente',
          function: mostrarDialog,
        ),
      );
      return;
    }

    weather.city = data['name'];
    weather.temp = (data['main']['temp']).round();
    weather.tempMin = (data['main']['temp_min']).round();
    weather.tempMax = (data['main']['temp_max']).round();
    weather.humidity = data['main']['humidity'].round();
    weather.wind = data['wind']['speed'].round();
    weather.condition = data['weather'][0]['id'];
    weather.description = data['weather'][0]['description'];

    sharedPreferences.setString('city', city);

    _selectBody(WeatherInfo(weather: weather));
  }

  void _selectBody(Widget body) {
    setState(() {
      _body = body;
    });
  }

  void mostrarDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cidade'),
          content: TextField(
            controller: myController,
            autocorrect: true,
            autofocus: true,
            onSubmitted: (texto) {
              //'Done'
              city = texto;
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('Pesquisar'),
              onPressed: () {
                print(myController.text);
                city = myController.text;
                myController.text = ''; //Limpando quando fecha.
                getData();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _setPortraitOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _setPortraitOnly();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                mostrarDialog();
              },
            )
          ],
        ),
        body: _body);
  }
}
