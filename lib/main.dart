import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/HabitTrackerApp.dart';
import 'package:flutter_application_1/layout/businessCardsPage.dart';
import 'package:flutter_application_1/layout/habitPage.dart';
import 'package:flutter_application_1/layout/quizPage.dart';
import 'package:flutter_application_1/layout/quizResult.dart';
import 'package:flutter_application_1/layout/settingsPage.dart';
import 'package:flutter_application_1/layout/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(StartApp());
}

class StartApp extends StatelessWidget {
  const StartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: StartPage());
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_main.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 2),
              Text("Willkommen in der Quiz App!", style: headerTextStyle()),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => QuizPage()),
                  );
                },
                child: Text("QUIZ STARTEN"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizResult(userPoints: 0),
                    ),
                  );
                },
                child: Text("Quiz Result"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Settingspage()),
                  );
                },
                child: Text("Settings"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HabitTrackerApp()),
                  );
                },
                child: Text("Habit Vibe MVP"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Habitpage()),
                  );
                },
                child: Text("Habit Selfbuild"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => businessCardsPage()),
                  );
                },
                child: Text("businessCardsPage"),
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
