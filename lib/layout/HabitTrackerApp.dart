import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(HabitTrackerApp());
}

enum FilterMode { Today, Weekly, Overall }

class HabitTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habits',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: Color(0xFFF2F2F7),
      ),
      home: HabitsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Habit {
  final String name;
  final String emoji;
  final Color color;
  final List<List<int>> yearData; // 52 Wochen × 7 Tage, 0 oder 1

  Habit({
    required this.name,
    required this.emoji,
    required this.color,
    required this.yearData,
  });

  int getTotalScore() => yearData.expand((w) => w).where((d) => d > 0).length;

  int getCurrentStreak() {
    int streak = 0;
    final all = yearData.expand((w) => w).toList().reversed;
    for (var v in all) {
      if (v > 0)
        streak++;
      else
        break;
    }
    return streak;
  }

  void addPoint() {
    final now = DateTime.now();
    final week = (now.difference(DateTime(now.year, 1, 1)).inDays / 7).floor();
    final day = now.weekday - 1;
    if (week < yearData.length && day < 7) {
      yearData[week][day] = 1;
    }
  }
}

class HabitsScreen extends StatefulWidget {
  @override
  _HabitsScreenState createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  FilterMode _filter = FilterMode.Weekly;
  List<Habit> habits = [
    Habit(
      name: 'Yoga',
      emoji: '🧘‍♀️',
      color: Color(0xFF34C759),
      yearData: _generateSampleYearData(),
    ),
  ];

  static List<List<int>> _generateSampleYearData() {
    return List.generate(52, (wi) {
      return List.generate(7, (di) {
        if (wi < 20) return (di + wi) % 3 == 0 ? 1 : 0;
        if (wi < 40) return (di + wi) % 4 == 0 ? 1 : 0;
        return (di + wi) % 5 == 0 ? 1 : 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CupertinoSegmentedControl<FilterMode>(
                groupValue: _filter,
                children: {
                  FilterMode.Today: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Text('Today'),
                  ),
                  FilterMode.Weekly: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Text('Weekly'),
                  ),
                  FilterMode.Overall: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Text('Overall'),
                  ),
                },
                onValueChanged: (m) => setState(() => _filter = m),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: habits.length,
                itemBuilder: (ctx, i) => _buildHabitCard(habits[i]),
              ),
            ),
            _buildAddButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Text(
        'Habits',
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget _buildHabitCard(Habit h) {
    final total = h.getTotalScore();
    final streak = h.getCurrentStreak();
    return GestureDetector(
      onTap: () {
        setState(() {
          h.addPoint();
        });
        _showSuccessAnimation();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(h.emoji, style: TextStyle(fontSize: 24)),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    h.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFF34C759),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '$total',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildHabitHistory(h),
          ],
        ),
      ),
    );
  }

  // ─────────────── Filtered History ───────────────
  Widget _buildHabitHistory(Habit h) {
    final now = DateTime.now();
    final week = (now.difference(DateTime(now.year, 1, 1)).inDays / 7).floor();
    final day = now.weekday - 1;
    switch (_filter) {
      case FilterMode.Today:
        final done = week < h.yearData.length && h.yearData[week][day] > 0;
        return Row(
          children: [
            Icon(
              done ? Icons.check_circle : Icons.radio_button_unchecked,
              color: done ? h.color : Color(0xFF8E8E93),
            ),
            SizedBox(width: 8),
            Text('Heute', style: TextStyle(color: Color(0xFF8E8E93))),
          ],
        );

      case FilterMode.Weekly:
        final labels = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];
        return Row(
          children: List.generate(7, (i) {
            final done = week < h.yearData.length && h.yearData[week][i] > 0;
            return Container(
              margin: EdgeInsets.only(right: 4),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: done ? h.color : Color(0xFFF2F2F7),
                border: Border.all(color: Color(0xFFE5E5EA)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  labels[i],
                  style: TextStyle(
                    fontSize: 9,
                    color: done ? Colors.white : Color(0xFF8E8E93),
                  ),
                ),
              ),
            );
          }),
        );

      case FilterMode.Overall:
      default:
        return Container(
          height: 120,
          child: CustomPaint(
            painter: CommitGridPainter(habit: h, cellSize: 12, spacing: 2),
            size: Size.infinite,
          ),
        );
    }
  }

  Widget _buildAddButton() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: _showAddHabitDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF007AFF),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 20),
              SizedBox(width: 8),
              Text(
                'Neue Gewohnheit',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessAnimation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Punkt hinzugefügt! 🎉'),
          ],
        ),
        backgroundColor: Color(0xFF34C759),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showAddHabitDialog() {
    final nameController = TextEditingController();
    String selectedEmoji = '⭐';
    Color selectedColor = Color(0xFF007AFF);

    final emojis = [
      '🧘‍♀️',
      '👨‍💻',
      '🏃‍♂️',
      '📚',
      '🧘',
      '💧',
      '🏋️‍♀️',
      '🎨',
      '🎵',
      '🌱',
      '☕',
      '🍎',
      '💤',
      '📝',
      '🚶‍♀️',
      '🧹',
      '📱',
      '🎯',
      '💰',
      '🌟',
      '🔥',
      '⚡',
      '🌙',
      '☀️',
      '🎲',
      '🎪',
      '🎭',
      '🎨',
      '🎸',
      '📷',
    ];
    final colors = [
      Color(0xFF007AFF),
      Color(0xFF34C759),
      Color(0xFFFF9500),
      Color(0xFF8E44AD),
      Color(0xFFFF3B30),
      Color(0xFF00C4E6),
      Color(0xFF5856D6),
      Color(0xFFFF2D92),
      Color(0xFF32D74B),
      Color(0xFFFFD60A),
      Color(0xFFBF5AF2),
      Color(0xFF6AC4DC),
    ];

    showDialog(
      context: context,
      builder:
          (ctx) => StatefulBuilder(
            builder:
                (ctx2, setD) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(
                    'Neue Gewohnheit',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          controller:
                              nameController, // Controller statt onChanged³
                          decoration: InputDecoration(
                            labelText: 'Name der Gewohnheit',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF2F2F7),
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Emoji auswählen:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          height: 120,
                          child: GridView.count(
                            crossAxisCount: 6,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            children:
                                emojis.map((e) {
                                  final sel = selectedEmoji == e;
                                  return GestureDetector(
                                    onTap: () => setD(() => selectedEmoji = e),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            sel
                                                ? selectedColor.withOpacity(0.2)
                                                : Color(0xFFF2F2F7),
                                        borderRadius: BorderRadius.circular(12),
                                        border:
                                            sel
                                                ? Border.all(
                                                  color: selectedColor,
                                                  width: 2,
                                                )
                                                : null,
                                      ),
                                      child: Center(
                                        child: Text(
                                          e,
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Farbe auswählen:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children:
                              colors.map((c) {
                                final sel = selectedColor == c;
                                return GestureDetector(
                                  onTap: () => setD(() => selectedColor = c),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: c,
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          sel
                                              ? Border.all(
                                                color: Colors.black,
                                                width: 3,
                                              )
                                              : null,
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: Text('Abbrechen'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        final name = nameController.text.trim();
                        if (name.isEmpty) return;
                        setState(() {
                          habits.add(
                            Habit(
                              name: name,
                              emoji: selectedEmoji,
                              color: selectedColor,
                              yearData: List.generate(
                                52,
                                (_) => List.filled(7, 0),
                              ),
                            ),
                          );
                        });
                        Navigator.pop(ctx);
                      },
                      child: Text('Hinzufügen'),
                    ),
                  ],
                ),
          ),
    );
  }
}

// ─────────────── Grid Painter ───────────────
class CommitGridPainter extends CustomPainter {
  final Habit habit;
  final double cellSize, spacing;

  CommitGridPainter({
    required this.habit,
    required this.cellSize,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..style = PaintingStyle.fill;
    for (int w = 0; w < 52; w++) {
      for (int d = 0; d < 7; d++) {
        final x = w * (cellSize + spacing);
        final y = d * (cellSize + spacing);
        if (x + cellSize > size.width) break;
        p.color = habit.yearData[w][d] > 0 ? habit.color : Color(0xFFF2F2F7);
        final rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, cellSize, cellSize),
          Radius.circular(3),
        );
        canvas.drawRRect(rect, p);
        p
          ..style = PaintingStyle.stroke
          ..color = Color(0xFFE5E5EA)
          ..strokeWidth = 0.5;
        canvas.drawRRect(rect, p);
        p.style = PaintingStyle.fill;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}
