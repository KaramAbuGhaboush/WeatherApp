import 'package:flutter/material.dart';
import 'package:flutter_application_2/daily_weather.dart';
import 'package:flutter_application_2/homepage.dart';
import 'package:flutter_application_2/hourly_weather.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main App',
      home: Home(),
      routes: {
        'home': (context) => Home(),
        'hour':(context) => const HourlyWeather(),
        'day':(context) => const DailyWeather()
      },
    );
  }
}
