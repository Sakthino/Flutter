import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(WeatherPage());
}

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: WeatherWidget(),
      ),
    );
  }
}

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  String _weatherData = '';

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final apiKey = 'YOUR_API_KEY'; // Replace with your OpenWeather API key
    final city = 'London'; // Example city
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final weatherMap = jsonDecode(response.body);
      setState(() {
        _weatherData = 'Temperature: ${weatherMap['main']['temp']}°C\n'
            'Weather: ${weatherMap['weather'][0]['main']}';
      });
    } else {
      setState(() {
        _weatherData = 'Failed to fetch weather data.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Weather Information',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          _weatherData.isNotEmpty
              ? Text(_weatherData)
              : CircularProgressIndicator(),
        ],
      ),
    );
  }
}