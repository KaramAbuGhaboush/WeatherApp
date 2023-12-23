import 'package:flutter/material.dart';
import 'package:flutter_application_2/daily_forecast.dart';
import 'package:flutter_application_2/drawer.dart';
import 'package:intl/intl.dart';

String city = 'Jerusalem';

class DailyWeather extends StatefulWidget {
  const DailyWeather({super.key});

  @override
  State<DailyWeather> createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
  List<DailyForecast>? dailyForecast;
  Future<List<DailyForecast>> getData() async {
    dailyForecast = await FetchDailyData.getData(city);
    return dailyForecast!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Weather'),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: dailyForecast!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                          'https:${dailyForecast![index].icon.toString()}'),
                      title: Text(
                        DateFormat('EEEE').format(
                          DateTime.parse(
                            dailyForecast![index].day.toString(),
                          ),
                        ),
                        style: const TextStyle(fontSize: 30),
                      ),
                      subtitle: Text(
                        dailyForecast![index].temp.toString(),
                        style: const TextStyle(fontSize: 30),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${dailyForecast![index].low.toString()}/',
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(
                            dailyForecast![index].high.toString(),
                            style: const TextStyle(fontSize: 30),
                          ),
                        ],
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
