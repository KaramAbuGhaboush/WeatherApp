import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CityProvider extends ChangeNotifier {
  String _city = 'Jerusalem';

  String get city => _city;

  void setCity(String city) {
    _city = city;
    notifyListeners();
  }
}
