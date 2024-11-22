import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '4a16506642f4b17081db8d1b3432cd4a';
  final String apiUrl = 'http://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> getWeatherData(
      double latitude, double longitude) async {
    final String url =
        '$apiUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
