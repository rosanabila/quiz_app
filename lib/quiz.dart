import 'package:flutter/material.dart';
import 'package:quiz_app/home_screen.dart';
import 'package:quiz_app/profile.dart';
import 'package:quiz_app/question_screen.dart';
import 'package:quiz_app/datas/questions.dart';
import 'package:quiz_app/result_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var activeScreen = 'start-screen';
  final List<String> selectedAnswer = [];

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswer.add(answer);

    if (selectedAnswer.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswer.clear();
      activeScreen = 'questions-screen';
    });
  }

  void profileScreen() {
    setState(() {
      activeScreen = 'profile-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = HomeScreen(
      startQuiz: switchScreen,
      profile: profileScreen,
    );

    if (activeScreen == 'question-screen') {
      screenWidget = QuestionScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (activeScreen == 'result-screen') {
      screenWidget = ResultScreen(
        choosenAnswers: selectedAnswer,
        onRestart: restartQuiz,
      );
    }

    if (activeScreen == 'profile-screen') {
      screenWidget = const Profile();
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.amber, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft)),
          child: screenWidget,
        ),
      ),
    );
  }
}
