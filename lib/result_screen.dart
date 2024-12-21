import 'package:flutter/material.dart';
import 'package:quiz_app/datas/questions.dart';
import 'package:quiz_app/question_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key, 
    required this.choosenAnswers,
    required this.onRestart,
    });

  final List<String> choosenAnswers;
  final void Function() onRestart;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    

    for (var i = 0; i < choosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': choosenAnswers[i]
        },
      );
    }

    return summary;
  }

  @override
  Widget build(context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQustions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQustions out of $numTotalQuestions question correctly !',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(
                getSummaryData()), // Memastikan sesuai dengan QuestionsSummary
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text(
                'Restart Quiz',
              style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
