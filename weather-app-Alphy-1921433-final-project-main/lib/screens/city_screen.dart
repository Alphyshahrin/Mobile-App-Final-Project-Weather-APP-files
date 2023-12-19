// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:weather_today_completed/utils/constants.dart';
import 'loading_screen.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final TextEditingController _cityNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'images/ic_back.png',
                      width: 32.0,
                    ),
                  ),
                ),
              ),
              Container(
                width: 300.0,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 24.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.orange, width: 2.0),
                ),
                child: TextField(
                  controller: _cityNameController,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: Colors.black,
                  ),
                  decoration: kTextFieldInputDecoration.copyWith(
                    hintText: 'Enter city name',
                    hintStyle: TextStyle(
                      color: Colors.black45,
                      fontFamily: 'monospace',
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                  primary: Colors.orange,
                ),
                onPressed: () {
                  String cityName = _cityNameController.text.trim();
                  if (cityName.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoadingScreen(cityName: cityName);
                        },
                      ),
                    );
                  } else {
                    // Handle the case when the cityName is empty
                    // You may want to show a message to the user or take appropriate action.
                  }
                },
                child: Text(
                  'Search Weather',
                  style: kButtonTextStyle.copyWith(
                    fontFamily: 'monospace',
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
