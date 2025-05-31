import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(String title) {
  return AppBar(title: Text(title), backgroundColor: Colors.white);
}

Widget answerCard(String text, BuildContext context, {bool? answer}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.1,
    width: MediaQuery.of(context).size.width,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      color:
          (answer == null)
              ? Colors.white
              : (answer)
              ? Colors.green
              : Colors.red,
      elevation: 3.5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

TextStyle headerTextStyle({Color color = Colors.black}) {
  return TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold);
}

TextStyle settingsHeaderStyle() {
  return TextStyle(fontWeight: FontWeight.bold, fontSize: 24);
}

ListTile settingsListTileStyle(
  String title,
  IconData trailingIcon,
  IconData leadingIcon,
) {
  return ListTile(
    title: Text(title, style: const TextStyle(fontSize: 18)),
    trailing: Icon(trailingIcon),
    leading: Icon(leadingIcon),
  );
}
