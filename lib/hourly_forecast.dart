import 'dart:convert';
import 'package:flutter_application_2/daily_weather.dart';
import 'package:http/http.dart' as http;

class FetchHourlyData {
  static Future<List<HourlyForecast>> getData(String cityParameter) async {
    city = cityParameter;
    String apiKey = 'a6e99024bdeb42808ad140441231911';
    final response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=1&aqi=no&alerts=no'));
    if (response.statusCode == 200) {
      List<dynamic> hourlyForecast =
          json.decode(response.body)['forecast']['forecastday'][0]['hour'];

      return hourlyForecast
          .map((dynamic item) => HourlyForecast.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class HourlyForecast {
  String? time;
  String? icon;
  double? temp;
  String? condition;

  HourlyForecast({
    required this.time,
    required this.icon,
    required this.temp,
    required this.condition,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: json['time'],
      icon: json['condition']['icon'],
      temp: json['temp_c'],
      condition: json['condition']['text'],
    );
  }
}
