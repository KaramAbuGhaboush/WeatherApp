import 'package:flutter/material.dart';
import 'package:flutter_application_2/city.dart';
import 'package:flutter_application_2/constants.dart';
import 'package:flutter_application_2/drawer.dart';
import 'package:flutter_application_2/hourly_forecast.dart';
import 'package:intl/intl.dart';

class HourlyWeather extends StatefulWidget {
  const HourlyWeather({super.key});

  @override
  State<HourlyWeather> createState() => _HourlyWeatherState();
}

class _HourlyWeatherState extends State<HourlyWeather> {
  Constants constants = Constants();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.withOpacity(0.5),
        title: const Text('Hourly Weather'),
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: FutureBuilder(
          future: FetchHourlyData.getData(City().getName()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<HourlyForecast>? hourlyForecast = snapshot.data;
              return ListView.builder(
                itemCount: hourlyForecast!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: hourlyForecast[index].temp! >= 5
                        ? constants.blackColor.withOpacity(0.2)
                        : constants.greyColor.withOpacity(0.2),
                    child: ListTile(
                      leading: Image.network(
                          'https:${hourlyForecast[index].icon.toString()}'),
                      title: Text(
                        DateFormat('HH:mm').format(DateTime.parse(
                            hourlyForecast[index].time.toString())),
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      subtitle: Text(
                        hourlyForecast[index].temp.toString(),
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      trailing: Text(
                        hourlyForecast[index].condition.toString(),
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
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
