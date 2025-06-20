import 'package:flutter/material.dart';
import '../models/habit.dart';

class HistoryGrid extends StatelessWidget {
  final Habit habit;
  final String selectedFilter;

  const HistoryGrid({
    super.key,
    required this.habit,
    required this.selectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    int days = _getFilterDays();
    
    if (days == 7) {
      // Für 7 Tage: Eine Reihe
      return _buildSingleRowGrid(days);
    } else if (days == 30) {
      // Für 30 Tage: 4 Reihen mit je 7-8 Tagen
      return _buildMultiRowGrid(days, 4);
    } else {
      // Für 365 Tage: Kompakte Darstellung der letzten 8 Wochen
      return _buildMultiRowGrid(56, 8);
    }
  }

  Widget _buildSingleRowGrid(int days) {
    return Row(
      children: List.generate(days, (index) {
        DateTime date = DateTime.now().subtract(Duration(days: days - 1 - index));
        String dateKey = date.toIso8601String().split('T')[0];
        bool isCompleted = habit.completedDays[dateKey] ?? false;
        bool isToday = index == days - 1;

        return Container(
          width: 12,
          height: 12,
          margin: EdgeInsets.only(right: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: isCompleted
                ? (isToday ? Colors.green : Colors.green.withValues(alpha: 0.7))
                : Colors.grey[300],
            border: isToday ? Border.all(color: Colors.black, width: 1) : null,
          ),
        );
      }),
    );
  }

  Widget _buildMultiRowGrid(int totalDays, int rows) {
    int daysPerRow = (totalDays / rows).ceil();
    
    return Column(
      children: List.generate(rows, (rowIndex) {
        int startDay = rowIndex * daysPerRow;
        int endDay = (startDay + daysPerRow).clamp(0, totalDays);
        
        return Padding(
          padding: EdgeInsets.only(bottom: rowIndex < rows - 1 ? 3 : 0),
          child: Row(
            children: List.generate(endDay - startDay, (colIndex) {
              DateTime date = DateTime.now().subtract(
                Duration(days: totalDays - 1 - (startDay + colIndex))
              );
              String dateKey = date.toIso8601String().split('T')[0];
              bool isCompleted = habit.completedDays[dateKey] ?? false;
              bool isToday = (startDay + colIndex) == totalDays - 1;

              return Container(
                width: totalDays > 56 ? 6 : 8,
                height: totalDays > 56 ? 6 : 8,
                margin: EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  color: isCompleted
                      ? (isToday ? Colors.green : Colors.green.withValues(alpha: 0.7))
                      : Colors.grey[300],
                  border: isToday ? Border.all(color: Colors.black, width: 0.5) : null,
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  int _getFilterDays() {
    switch (selectedFilter) {
      case '7 Tage':
        return 7;
      case '30 Tage':
        return 30;
      case '365 Tage':
        return 365;
      default:
        return 7;
    }
  }
}