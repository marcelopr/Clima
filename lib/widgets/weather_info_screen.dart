import 'package:flutter/material.dart';
import 'package:tempocerto/models/weather.dart';

class WeatherInfo extends StatefulWidget {
  Weather weather;

  WeatherInfo({Key key, @required this.weather}) : super(key: key);
  //passar objeto Weather pelo construtor

  _WeatherInfoState createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  Row _tempExtreme({int temp, Icon icon}) {
    return Row(
      children: <Widget>[
        icon,
        Text(
          widget.weather.formatTemp(temp),
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Column _extraInfo({String info, String icon}) {
    return Column(
      children: <Widget>[
        Image.asset(
          icon,
          color: Colors.white,
          width: 24,
          height: 24,
        ),
        SizedBox(height: 12),
        Text(info),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.weather.temp.toString());

    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  widget.weather.city,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _tempExtreme(
                        temp: widget.weather.tempMin,
                        icon: Icon(Icons.arrow_downward)),
                    SizedBox(width: 14),
                    _tempExtreme(
                        temp: widget.weather.tempMax,
                        icon: Icon(Icons.arrow_upward)),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset(
                  widget.weather.getWeatherImage(widget.weather.condition),
                  color: Colors.white,
                  width: 80,
                  height: 80,
                ),
                //widget.weather.getWeatherImage(widget.weather.condition),
                SizedBox(height: 24),
                Text(
                  //'2º',
                  widget.weather.formatTemp(widget.weather.temp),
                  style: TextStyle(fontSize: 92),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _extraInfo(
                info: widget.weather.formatHumidity(),
                icon: 'lib/assets/ic_humidity.png',
              ),
              SizedBox(width: 30),
              _extraInfo(
                info: widget.weather.formatWind(),
                icon: 'lib/assets/ic_wind.png',
              ),
            ],
          ),
        )
      ],
    );
  }
}
