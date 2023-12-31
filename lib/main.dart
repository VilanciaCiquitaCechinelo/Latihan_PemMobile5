import 'package:appwrite/appwrite.dart';
import 'package:cuaca/firebase_options.dart';
import 'package:cuaca/notification_handler.dart';
import 'package:cuaca/views/loginview.dart';
import 'package:cuaca/views/openview.dart';
import 'package:cuaca/views/registerview.dart';
import 'package:cuaca/views/startview.dart';
import 'package:cuaca/views/welcomeview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeAppwrite();
  await initializeFirebase();
  await initializeSharedPreferences();
  await initializePushNotification();
  runApp(MyApp());
}

Future<void> initializeAppwrite() async {
  Client client = Client();
  client
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('65670dbb96ee3d2a1d82')
      .setSelfSigned(status: true); // For self signed certificates, only use for development
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> initializeSharedPreferences() async {
  await Get.putAsync(() async => await SharedPreferences.getInstance());
}

Future<void> initializePushNotification() async {
  await FirebaseMessagingHandler().initPushNotification();
  // await FirebaseMessagingHandler().initLocalNotification();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/': (context) => StartPage(),
        '/open': (context) => OpenPage(),
      },
    );
  }
}
