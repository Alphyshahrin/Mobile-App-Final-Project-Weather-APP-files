import 'package:flutter/material.dart';
import 'package:weather_today_completed/utils/constants.dart';
import '../utils/custom_paint.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  int temperature = 0;
  int minTemperature = 0;
  int maxTemperature = 0;
  double windSpeed = 0.0;
  int humidity = 50;

  String cityName = "Dhaka";

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      double minTemp = weatherData['main']['temp_min'];
      minTemperature = minTemp.toInt();

      double maxTemp = weatherData['main']['temp_max'];
      maxTemperature = maxTemp.toInt();

      double ws = weatherData['wind']['speed'].toDouble();
      windSpeed = ws;

      int humid = weatherData['main']['humidity'];
      humidity = humid.toInt();

      String city = weatherData['name'];
      cityName = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.09),
              BlendMode.darken,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.only(
                  top: 24,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Align items vertically at the center
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '$temperature°',
                        style: kTempTextStyle,
                        textAlign: TextAlign
                            .center, // Align the temperature text at the center
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ConditionRow(
                      icon: 'images/ic_temp.png',
                      title: 'Min Temp',
                      value: '$minTemperature°',
                    ),
                    ConditionRow(
                      icon: 'images/ic_wind_speed.png',
                      title: 'Wind Speed',
                      value: '${windSpeed.toStringAsFixed(1)} Km/h',
                    ),
                    ConditionRow(
                      icon: 'images/ic_temp.png',
                      title: 'Max Temp',
                      value: '$maxTemperature°',
                    ),
                    ConditionRow(
                      icon: 'images/ic_humidity.png',
                      title: 'Humidity',
                      value: '$humidity%',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  cityName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      top: 10.0,
                      right: 10.0,
                      child: GestureDetector(
                        onTap: () async {},
                        child: Image.asset(
                          'images/lock.png',
                          width: 32.0,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10.0,
                      left: 10.0,
                      child: GestureDetector(
                        onTap: () {
                          final cityName = Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CityScreen();
                              },
                            ),
                          );

                          // use city name
                        },
                        child: Image.asset(
                          'images/searchbar.png',
                          width: 32.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConditionRow extends StatelessWidget {
  final String icon;
  final String title;
  final String value;

  const ConditionRow({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          icon,
          width: 24.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Text(
            title,
            style: kConditionTextStyleSmall,
          ),
        ),
        Text(
          value,
          style: kConditionTextStyle,
        ),
      ],
    );
  }
}
