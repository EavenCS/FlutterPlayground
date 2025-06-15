import 'package:http/http.dart' as http;
import 'dart:convert';

class OpenWeatherFetcher {
  final String apiKey;

  OpenWeatherFetcher(this.apiKey);

  Future<Map<String, dynamic>?> fetchWeather(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
