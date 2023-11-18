import 'package:cuaca/controllers/weatherapi.dart';
import 'package:cuaca/models/weathermodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpenPage extends StatefulWidget {
  const OpenPage({Key? key});

  @override
  _OpenPageState createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {
  TextEditingController _locationController = TextEditingController();
  List<String> _locations = [];
  List<WeatherModel> _weatherData = [];

  @override
  void initState() {
    super.initState();
    _loadSavedLocations();
  }

  _loadSavedLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _locations = prefs.getStringList('locations') ?? [];
    });
    _fetchWeatherData();
  }

  _saveLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('locations', _locations);
  }

  _fetchWeatherData() async {
    List<WeatherModel> weatherDataList = [];

    for (String location in _locations) {
      try {
        WeatherModel weatherModel = await WeatherApi.getWeather(location);
        weatherDataList.add(weatherModel);
      } catch (e) {
        print('Error fetching weather for $location: $e');
      }
    }

    setState(() {
      _weatherData = weatherDataList;
    });
  }

  _deleteLocation(int index) {
    setState(() {
      _locations.removeAt(index);
      _saveLocations();
      _fetchWeatherData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurpleAccent,
              Colors.white70,
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        hintText: 'Type location here',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        String location = _locationController.text;
                        if (location.isNotEmpty) {
                          _locations.add(location);
                          _locationController.clear();
                          _saveLocations();
                          _fetchWeatherData();
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _weatherData.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      _deleteLocation(index);
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(_locations[index]),
                        subtitle: Text(
                          'Weather: ${_weatherData[index].description}, Temperature: ${_weatherData[index].temperature.toStringAsFixed(2)} °C',
                        ),
                        trailing: Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}