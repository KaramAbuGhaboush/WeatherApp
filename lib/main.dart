import 'package:flutter/material.dart';
import 'package:flutter_application_2/daily_weather.dart';
import 'package:flutter_application_2/homepage.dart';
import 'package:flutter_application_2/hourly_weather.dart';
import 'package:flutter_application_2/places_service.dart';

main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main App',
      home: const Home(),
      routes: {
        'home': (context) => const Home(),
        'hour': (context) => const HourlyWeather(),
        'day': (context) => const DailyWeather(),
        'city': (context) => const PlacesScreen(),
      },
    );
  }
}
