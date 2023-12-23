import 'package:flutter/material.dart';
import 'package:flutter_application_2/drawer.dart';
import 'package:flutter_application_2/google_map_api.dart';
import 'package:flutter_application_2/location_provider.dart';
import 'package:flutter_application_2/test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherData? weatherData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MainPage'),
        ),
        drawer: const CustomDrawer(),
        body: Center(child:
            Consumer<CityProvider>(builder: (context, cityProvider, child) {
          return FutureBuilder(
              future: FetchData(cityProvider.city).getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  weatherData = snapshot.data as WeatherData;
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
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'hour');
                          },
                          child: const Text('Hourly Weather')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'day');
                          },
                          child: const Text('Daily Weather')),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              });
        })),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.location_city),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: GoogleMapApi()
                        .getInitialCameraPosition() as CameraPosition,
                    onMapCreated: (GoogleMapController controller) {
                      GoogleMapApi().setController(controller);
                    },
                  );
                });
          },
        ));
  }
}
