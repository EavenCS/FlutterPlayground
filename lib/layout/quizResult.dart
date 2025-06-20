import 'package:flutter/material.dart';

class QuizResult extends StatelessWidget {
  final int userPoints;

  const QuizResult({super.key, required this.userPoints});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_main.png"),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Card(
          elevation: 8,
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Dein Ergebnis: $userPoints Punkte",
              style: TextStyle(fontSize: 18, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
