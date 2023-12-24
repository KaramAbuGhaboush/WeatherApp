import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchData {
  static Future<WeatherData> getData(String city) async {
    String apiKey = 'a6e99024bdeb42808ad140441231911';
    final response = await http.get(Uri.parse(
        'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=1&aqi=no&alerts=no'));
    if (response.statusCode == 200) {
      return WeatherData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class WeatherData {
  String icon;
  String location;
  String temp;
  String condition;
  String wind;
  String humidity;

  WeatherData({
    required this.icon,
    required this.location,
    required this.temp,
    required this.condition,
    required this.wind,
    required this.humidity,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      icon: json['current']['condition']['icon'],
      location: json['location']['name'],
      temp: json['current']['temp_c'].toString(),
      condition: json['current']['condition']['text'],
      wind: json['current']['wind_kph'].toString(),
      humidity: json['current']['humidity'].toString(),
    );
  }
}
