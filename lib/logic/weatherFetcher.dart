import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class OpenWeatherFetcher {
  final String apiKey;

  OpenWeatherFetcher(this.apiKey);

  Future<void> fetchWeather(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        printWeatherData(data);
      } else {
        print('Fehler: ${response.statusCode}');
      }
    } catch (e) {
      print('Fehler beim Abruf: $e');
    }
  }

  void printWeatherData(Map<String, dynamic> data) {
    final temp = data['main']['temp'];
    final weather = data['weather'][0]['description'];
    print('Aktuelle Temperatur: $temp °C');
    print('Wetter: $weather');
  }
}

Future<void> main() async {
  await dotenv.load();

  final apiKey = dotenv.env['OPENWEATHER_API_KEY'];

  if (apiKey == null) {
    print('API Key nicht gefunden!');
    return;
  }

  final fetcher = OpenWeatherFetcher(apiKey);
  await fetcher.fetchWeather('Berlin');
}
