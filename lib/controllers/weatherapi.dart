import 'package:cuaca/models/weathermodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApi {
  static Future<WeatherModel> getWeather(String location) async {
    final apiKey = '53efa6a6286aa9ae7bdebff18665eac6';
    final response = await http.get(
      Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final weatherDescription = data['weather'][0]['description'];
      final temperature = (data['main']['temp'] - 273.15).toDouble(); // Convert temperature to Celsius
      return WeatherModel(description: weatherDescription, temperature: temperature);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}