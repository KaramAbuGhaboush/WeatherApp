import 'package:flutter/material.dart';
import 'package:flutter_application_2/drawer.dart';
import 'package:flutter_application_2/hourly_forecast.dart';

class HourlyWeather extends StatefulWidget {
  const HourlyWeather({super.key});

  @override
  State<HourlyWeather> createState() => _HourlyWeatherState();
}

class _HourlyWeatherState extends State<HourlyWeather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hourly Weather'),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: FutureBuilder(
          future: FetchHourlyData.getData('Jerusalem'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<HourlyForecast>? hourlyForecast = snapshot.data;
              return ListView.builder(
                itemCount: hourlyForecast!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                          'https:${hourlyForecast[index].icon.toString()}'),
                      title: Text(
                        hourlyForecast[index].time.toString(),
                        style: const TextStyle(fontSize: 30),
                      ),
                      subtitle: Text(
                        hourlyForecast[index].temp.toString(),
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  );
                },
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
