import 'package:flutter/material.dart';

TextField customTextField(
  TextEditingController controller, {
  String label = 'Eingabe',
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF007AFF)),
      ),
    ),
  );
}
