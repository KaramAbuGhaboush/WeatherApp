import 'package:flutter/material.dart';
import 'package:flutter_application_2/city.dart';
import 'package:flutter_application_2/drawer.dart';
import 'package:flutter_application_2/test.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  List<String> places = [
    'Jerusalem',
    'Amman',
    'London',
    'New York',
    'Cairo',
    'Moscow',
    'Riyad',
    'Berlin',
    'Bejing',
    'Venice',
    'Rome',
    'Milan',
    'Paris',
    'Madrid',
    'Barcelona',
    'Tokyo',
    'Seoul',
    'Bangkok',
    'Dubai',
    'Istanbul'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Places'),
        ),
        drawer: const CustomDrawer(),
        body: Center(
          child: ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              return FutureBuilder(
                future: FetchData.getData(places[index]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    WeatherData weatherData = snapshot.data as WeatherData;
                    return Card(
                      color: Colors.blueAccent.withOpacity(0.2),
                      child: ListTile(
                          leading: Image.network('https:${weatherData.icon}'
                              .replaceAll('64x64', '128x128')),
                          title: Text(
                            weatherData.location,
                            style: const TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          subtitle: Text(
                            weatherData.temp,
                            style: const TextStyle(fontSize: 30),
                          ),
                          trailing: Text(
                            weatherData.condition,
                            style: const TextStyle(fontSize: 30),
                          ),
                          onTap: () {
                            Navigator.pushReplacementNamed(context, 'home',
                                arguments: weatherData);
                            setState(() {
                              City.setName(weatherData.location);
                            });
                          }),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              );
            },
          ),
        ));
  }
}
