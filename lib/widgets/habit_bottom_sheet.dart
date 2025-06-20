import 'package:flutter/material.dart';
import '../layout/habitWidgets.dart';
import '../models/habit.dart';

class HabitBottomSheet extends StatelessWidget {
  final Function(Habit) onHabitAdded;

  const HabitBottomSheet({
    super.key,
    required this.onHabitAdded,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController habitController = TextEditingController();
    IconData selectedIcon = Icons.track_changes;

    return StatefulBuilder(
      builder: (context, setModalState) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFF8E8E93),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Neue Gewohnheit hinzufügen',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  customTextField(habitController, label: 'Gewohnheit'),
                  SizedBox(height: 20),
                  Text(
                    'Icon auswählen',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Icons.fitness_center,
                        Icons.book,
                        Icons.water_drop,
                        Icons.bedtime,
                        Icons.restaurant,
                        Icons.directions_run,
                        Icons.self_improvement,
                        Icons.music_note,
                        Icons.brush,
                        Icons.work,
                        Icons.school,
                        Icons.favorite,
                        Icons.shopping_cart,
                        Icons.home,
                        Icons.pets,
                      ]
                          .map(
                            (icon) => GestureDetector(
                              onTap: () {
                                setModalState(() {
                                  selectedIcon = icon;
                                });
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectedIcon == icon
                                      ? Color(0xFF007AFF)
                                      : Colors.grey[200],
                                ),
                                child: Icon(
                                  icon,
                                  color: selectedIcon == icon
                                      ? Colors.white
                                      : Colors.grey[600],
                                  size: 24,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (habitController.text.isNotEmpty) {
                          final newHabit = Habit(
                            name: habitController.text,
                            icon: selectedIcon,
                          );
                          onHabitAdded(newHabit);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Gewohnheit "${habitController.text}" hinzugefügt',
                              ),
                              backgroundColor: Color(0xFF007AFF),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF007AFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Hinzufügen',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}