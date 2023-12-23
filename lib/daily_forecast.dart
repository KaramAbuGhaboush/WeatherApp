import 'dart:convert';
import 'package:flutter_application_2/daily_weather.dart';
import 'package:http/http.dart' as http;

class FetchDailyData {
  static Future<List<DailyForecast>> getData(String cityParameter) async {
    String city = cityParameter;
    String apiKey = 'a6e99024bdeb42808ad140441231911';
    final response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=5&aqi=no&alerts=no'));
    if (response.statusCode == 200) {
      List<dynamic> dailyForecast =
          json.decode(response.body)['forecast']['forecastday'];

      return dailyForecast
          .map((dynamic item) => DailyForecast.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  FetchDailyData(String cityParameter) {
    city = cityParameter;
  }
}

class DailyForecast {
  String? day;
  String? icon;
  String? high;
  String? low;
  String? temp;

  DailyForecast({
    required this.day,
    required this.icon,
    required this.high,
    required this.low,
    required this.temp,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      day: json['date'],
      icon: json['hour'][0]['condition']['icon'],
      high: json['day']['maxtemp_c'].toString(),
      low: json['day']['mintemp_c'].toString(),
      temp: json['hour'][0]['temp_c'].toString(),
    );
  }
}
