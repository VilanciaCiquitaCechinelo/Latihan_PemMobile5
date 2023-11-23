import 'package:cuaca/controllers/startcontroller.dart';
import 'package:cuaca/userprofilepage.dart';
import 'package:cuaca/views/openview.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  final StartPageController _controller = StartPageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/cloudy.png',
                    width: 200,
                    height: 200,
                  ),
                  const Text(
                    'Weather Mobile App',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _controller.getWeatherInfo(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfilePage(
                        profileImage: null,
                        nama: 'Nama Pengguna',
                        email: 'pengguna@example.com',
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 50,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: Icon(
                    Icons.settings,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            child: Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OpenPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                ),
                child: Text('Start'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}