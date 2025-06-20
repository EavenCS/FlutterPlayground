import 'package:flutter/material.dart';

class Habit {
  String name;
  IconData icon;
  Map<String, bool> completedDays;

  Habit({
    required this.name,
    this.icon = Icons.track_changes,
    Map<String, bool>? completedDays,
  }) : completedDays = completedDays ?? {};

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'iconCodePoint': icon.codePoint,
      'completedDays': completedDays,
    };
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      name: json['name'],
      icon: IconData(json['iconCodePoint'], fontFamily: 'MaterialIcons'),
      completedDays: Map<String, bool>.from(json['completedDays'] ?? {}),
    );
  }
}