import 'package:flutter/material.dart';
import 'package:flutter_application_2/city.dart';
import 'package:flutter_application_2/constants.dart';
import 'package:flutter_application_2/drawer.dart';
import 'package:flutter_application_2/test.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherData? weatherData;

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainPage'),
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: FutureBuilder(
          future: FetchData.getData(City().getName()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              weatherData = snapshot.data as WeatherData;
              return Container(
                height: 700,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: constants.blackColor, width: 5),
                  gradient: constants.linearGradientBlue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      weatherData!.location,
                      style: const TextStyle(fontSize: 30),
                    ),
                    Image.network('https:${weatherData!.icon}'
                        .replaceAll('64x64', '128x128')),
                    Text(
                      weatherData!.temp,
                      style: const TextStyle(fontSize: 60),
                    ),
                    Text(
                      weatherData!.condition,
                      style: const TextStyle(fontSize: 30),
                    ),
                    Text(
                      'wind: ${weatherData!.wind}',
                      style: const TextStyle(fontSize: 30),
                    ),
                    Text(
                      'humidity: ${weatherData!.humidity}',
                      style: const TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
