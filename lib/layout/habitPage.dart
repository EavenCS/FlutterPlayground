import 'package:flutter/material.dart';

class Habitpage extends StatefulWidget {
  const Habitpage({super.key});

  @override
  State<Habitpage> createState() => _HabitpageState();
}

class _HabitpageState extends State<Habitpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Habits"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              // do something
            },
          ),
        ],
      ),
    );
  }
}
