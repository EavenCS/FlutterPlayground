import 'package:flutter/material.dart';
import 'package:flutter_application_1/logic/weatherFetcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Habitpage extends StatefulWidget {
  const Habitpage({super.key});

  @override
  State<Habitpage> createState() => _HabitpageState();
}

class _HabitpageState extends State<Habitpage> {
  String? temperature;
  String? description;

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  Future<void> loadWeather() async {
    final apiKey = dotenv.env['OPENWEATHER_API_KEY'];

    if (apiKey == null) {
      print('API Key nicht gefunden!');
      return;
    }

    final fetcher = OpenWeatherFetcher(apiKey);
    final data = await fetcher.fetchWeather('Berlin');

    if (data != null) {
      setState(() {
        temperature = data['main']['temp'].toString();
        description = data['weather'][0]['description'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Habits",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Color(0xFFF2F2F7),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3.5,
                    color: Colors.white,
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child:
                            temperature == null
                                ? CircularProgressIndicator(color: Color(0xFF007AFF))
                                : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${temperature?.split('.')[0]}°C',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      description ?? '',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF8E8E93),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3.5,
                    color: Colors.white,
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          "Daily Task",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Color(0xFF007AFF),
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF007AFF),
        unselectedItemColor: Color(0xFF8E8E93),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Habits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt), 
            label: 'Tasks'
          ),
        ],
      ),
    );
  }
}
