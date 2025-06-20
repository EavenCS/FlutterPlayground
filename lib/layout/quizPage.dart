import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/quizResult.dart';
import 'package:flutter_application_1/layout/widgets.dart';
import 'package:flutter_application_1/logic/questionController.dart';
import 'package:flutter_application_1/logic/questions.dart';
import 'package:flutter_application_1/model/quiz_model.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentLevel = 1;
  int userPoints = 0;
  int count = 0;
  late QuizModel currentQuestion;
  late List<String> answers;
  late List<int> questionIndex;
  List<bool?> answersValidate = [null, null, null, null];
  bool isAnswering = false;

  @override
  void initState() {
    super.initState();
    questionIndex = getRandomQuestionIndex(10);
    loadNewQuestion();
  }

  loadNewQuestion() {
    setState(() {
      currentQuestion = loadQuestion(questionIndex[currentLevel - 1]);
      answers = getRandomQuestionList(
        List<String>.from(currentQuestion.wrongAnswers),
        currentQuestion.correctAnswer,
      );
      answersValidate = [null, null, null, null];
      isAnswering = false;
    });
  }

  validateAndShowQuestion(int userAnswerIndex) async {
    if (isAnswering) return; // Verhindert mehrfache Ausführung

    setState(() {
      isAnswering = true;
      int correctIndex = getCorrectAnswerIndex(
        answers,
        currentQuestion.correctAnswer,
      );
      answersValidate[correctIndex] = true;
      if (userAnswerIndex == correctIndex) {
        userPoints++;
      } else {
        answersValidate[userAnswerIndex] = false;
      }
    });

    await Future.delayed(Duration(seconds: 2));

    currentLevel++;

    if (currentLevel > 10) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QuizResult(userPoints: userPoints),
          settings: RouteSettings(
            arguments: {'userPoints': userPoints, 'totalQuestions': 10},
          ),
        ),
      );
    } else {
      loadNewQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_main.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  currentQuestion.question,
                  style: headerTextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                Text(
                  "Aktuelles Level: $currentLevel/10",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 10),
                StepProgressIndicator(
                  totalSteps: 10,
                  currentStep: currentLevel,
                  selectedColor: const Color.fromARGB(255, 1, 255, 6),
                  unselectedColor: const Color.fromARGB(255, 255, 0, 0),
                ),
                SizedBox(height: 10),
                Text(
                  "Punkte: $userPoints",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Spacer(flex: 2),
                GestureDetector(
                  onTap:
                      isAnswering
                          ? null
                          : () {
                            validateAndShowQuestion(0);
                          },
                  child: answerCard(
                    answers[0],
                    context,
                    answer: answersValidate[0],
                  ),
                ),
                GestureDetector(
                  onTap:
                      isAnswering
                          ? null
                          : () {
                            validateAndShowQuestion(1);
                          },
                  child: answerCard(
                    answers[1],
                    context,
                    answer: answersValidate[1],
                  ),
                ),
                GestureDetector(
                  onTap:
                      isAnswering
                          ? null
                          : () {
                            validateAndShowQuestion(2);
                          },
                  child: answerCard(
                    answers[2],
                    context,
                    answer: answersValidate[2],
                  ),
                ),
                GestureDetector(
                  onTap:
                      isAnswering
                          ? null
                          : () {
                            validateAndShowQuestion(3);
                          },
                  child: answerCard(
                    answers[3],
                    context,
                    answer: answersValidate[3],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
