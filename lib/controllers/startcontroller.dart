import 'package:cuaca/models/startmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StartPageController {
  final WeatherModel _weatherModel = WeatherModel();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getWeatherInfo() {
    return _weatherModel.getWeatherInfo();
  }

  void onButtonPressed(BuildContext context) {
    Navigator.pushNamed(context, '/open');
  }

  bool isUserLoggedIn() {
    User? user = _auth.currentUser;
    return user != null; // Mengembalikan true jika ada pengguna yang login
  }
}