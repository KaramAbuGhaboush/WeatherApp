import 'package:flutter/material.dart';
import 'package:flutter_application_2/test.dart';

class Haitham extends StatefulWidget {
  const Haitham({super.key});

  @override
  State<Haitham> createState() => _HaithamState();
}

class _HaithamState extends State<Haitham> {
  WeatherData? weatherData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Haitham'),
      ),
      body: Center(
        child: FutureBuilder(
          future: FetchData('Jerusalem').getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              weatherData = snapshot.data as WeatherData?;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weatherData!.location,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Text(
                    weatherData!.temp,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Text(
                    weatherData!.condition,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Text(
                    weatherData!.wind,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Text(
                    weatherData!.humidity,
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
