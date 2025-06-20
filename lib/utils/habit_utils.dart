import '../models/habit.dart';

class HabitUtils {
  static int getStreakCount(Habit habit, String selectedFilter) {
    int streak = 0;
    DateTime currentDate = DateTime.now();
    int maxDays = getFilterDays(selectedFilter);

    for (int i = 0; i < maxDays; i++) {
      String dateKey = currentDate
          .subtract(Duration(days: i))
          .toIso8601String()
          .split('T')[0];
      if (habit.completedDays[dateKey] == true) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }

  static String getCompletionStats(Habit habit, String selectedFilter) {
    int days = getFilterDays(selectedFilter);
    int completedDays = 0;
    
    for (int i = 0; i < days; i++) {
      DateTime date = DateTime.now().subtract(Duration(days: i));
      String dateKey = date.toIso8601String().split('T')[0];
      if (habit.completedDays[dateKey] == true) {
        completedDays++;
      }
    }
    
    double percentage = days > 0 ? (completedDays / days * 100) : 0;
    return '$completedDays/$days Tage (${percentage.toStringAsFixed(0)}%) - $selectedFilter';
  }

  static int getFilterDays(String selectedFilter) {
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