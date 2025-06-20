import 'package:flutter/material.dart';
import 'package:flutter_application_1/logic/weatherFetcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/habit.dart';
import '../widgets/filter_buttons.dart';
import '../widgets/history_grid.dart';
import '../widgets/habit_bottom_sheet.dart';
import '../utils/habit_utils.dart';

class Habitpage extends StatefulWidget {
  const Habitpage({super.key});

  @override
  State<Habitpage> createState() => _HabitpageState();
}


class _HabitpageState extends State<Habitpage> {
  String? temperature;
  String? description;
  List<Habit> habits = [];
  String selectedFilter = '7 Tage';

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

  void _showAddHabitBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => HabitBottomSheet(
        onHabitAdded: (habit) {
          setState(() {
            habits.add(habit);
          });
        },
      ),
    );
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
          FilterButtons(
            selectedFilter: selectedFilter,
            onFilterChanged: (filter) {
              setState(() {
                selectedFilter = filter;
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  habits.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.track_changes,
                              size: 64,
                              color: Color(0xFF8E8E93),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Noch keine Gewohnheiten',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF8E8E93),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Tippe auf + um deine erste Gewohnheit hinzuzufügen',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8E8E93),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                      : ListView.builder(
                        itemCount: habits.length,
                        itemBuilder: (context, index) {
                          final habit = habits[index];
                          final today =
                              DateTime.now().toIso8601String().split('T')[0];
                          final isCompletedToday =
                              habit.completedDays[today] ?? false;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                              child: ListTile(
                                leading: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      habit.completedDays[today] =
                                          !isCompletedToday;
                                    });
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          isCompletedToday
                                              ? Colors.green
                                              : Color(0xFF007AFF),
                                    ),
                                    child: Icon(
                                      isCompletedToday
                                          ? Icons.check
                                          : habit.icon,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  habit.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    decoration:
                                        isCompletedToday
                                            ? TextDecoration.lineThrough
                                            : null,
                                    color:
                                        isCompletedToday
                                            ? Color(0xFF8E8E93)
                                            : Colors.black,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isCompletedToday
                                          ? 'Heute erledigt ✓'
                                          : 'Heute noch offen',
                                      style: TextStyle(
                                        color:
                                            isCompletedToday
                                                ? Colors.green
                                                : Color(0xFF8E8E93),
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      HabitUtils.getCompletionStats(habit, selectedFilter),
                                      style: TextStyle(
                                        color: Color(0xFF8E8E93),
                                        fontSize: 11,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    HistoryGrid(
                                      habit: habit,
                                      selectedFilter: selectedFilter,
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${HabitUtils.getStreakCount(habit, selectedFilter)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF007AFF),
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.local_fire_department,
                                      color: Colors.orange,
                                      size: 16,
                                    ),
                                    SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          habit.completedDays[today] =
                                              !isCompletedToday;
                                        });
                                      },
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              isCompletedToday
                                                  ? Colors.green
                                                  : Colors.grey[300],
                                          border: Border.all(
                                            color:
                                                isCompletedToday
                                                    ? Colors.green
                                                    : Colors.grey[400]!,
                                            width: 2,
                                          ),
                                        ),
                                        child:
                                            isCompletedToday
                                                ? Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 18,
                                                )
                                                : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: () => _showAddHabitBottomSheet(context),
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
          BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: 'Tasks'),
        ],
      ),
    );
  }
}
