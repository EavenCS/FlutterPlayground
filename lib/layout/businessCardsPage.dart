import 'package:flutter/material.dart';

class businessCardsPage extends StatefulWidget {
  const businessCardsPage({super.key});

  @override
  State<businessCardsPage> createState() => _businessCardsPageState();
}

class _businessCardsPageState extends State<businessCardsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text("businessCardsPage")),
      body: Center(
        child: Container(
          color: Colors.white,
          width: 350,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(Icons.account_circle, size: 100),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Eaven Schmalz", textScaleFactor: 2),
                        Text("Software Entwickler", textScaleFactor: 1.2),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("123 Musterstraße"), Text("+4534567633")],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.accessibility, size: 35),
                    Icon(Icons.timer, size: 35),
                    Icon(Icons.phone, size: 35),
                    Icon(Icons.phone_iphone, size: 35),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
