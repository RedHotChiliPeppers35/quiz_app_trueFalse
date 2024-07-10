import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_true_false/ViewModel/main_page.dart';

class ResultPage extends StatefulWidget {
  ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  TextStyle resultStyle50 = const TextStyle(fontSize: 50);

  TextStyle resultStyle30 = const TextStyle(fontSize: 25);

  TextStyle resultStyle20 = const TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    String resultComment;
    if (quizViewModel.correctAnswers >= 7) {
      resultComment = "Well Done !";
    } else if (quizViewModel.correctAnswers >= 5) {
      resultComment = "Good Job !";
    } else {
      resultComment = 'Better luck next time!';
    }

    void restartQuiz() {
      setState(() {
        quizViewModel.currentQuestionIndex = 0;
        quizViewModel.correctAnswers = 0;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  resultComment,
                  style: resultStyle50,
                ),
                Text(
                  "You have correctly answered",
                  textAlign: TextAlign.start,
                  style: resultStyle30,
                ),
                Text(
                  "${quizViewModel.correctAnswers.toString()} out of ${quizViewModel.questions.length.toString()} questions",
                  style: resultStyle30,
                  textAlign: TextAlign.start,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: TextButton(
                        onPressed: () {
                          restartQuiz();
                          Navigator.of(context).push(CupertinoDialogRoute(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => MainPage(),
                          ));
                        },
                        child: Text(
                          "Try Again",
                          style: resultStyle20,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
