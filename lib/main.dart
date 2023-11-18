import 'package:cuaca/views/loginview.dart';
import 'package:cuaca/views/openview.dart';
import 'package:cuaca/views/startview.dart';
import 'package:cuaca/views/welcomeview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      initialRoute: '/welcome',
      routes: {
        '/': (context) => StartPage(),
        '/open': (context) => OpenPage(),
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}