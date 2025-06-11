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
        centerTitle: false,
        title: Text(
          "Habits",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              // do something
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: Container(height: 100, color: Colors.red)),
              Expanded(child: Container(height: 100, color: Colors.blue)),
            ],
          ),
        ],
      ),
    );
  }
}
