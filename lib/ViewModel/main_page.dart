import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_true_false/ViewModel/quizViewModel.dart';
import 'package:quiz_app_true_false/ViewModel/result_page.dart';

QuizViewModel quizViewModel = QuizViewModel();

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextStyle trueFalseTextStyle =
      const TextStyle(color: Colors.white, fontSize: 20);
  TextStyle questionStyle = const TextStyle(color: Colors.white, fontSize: 30);

  static const questionTime = 3; // in seconds

  int timeLeft = questionTime;
  Timer? myTimer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void startTimer() {
    myTimer?.cancel();
    timeLeft = questionTime;
    myTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else if (timeLeft == 0) {
          timeLeft = questionTime;
          if (quizViewModel.currentQuestionIndex == 9) {
            timer.cancel();
            Navigator.of(context).push(CupertinoDialogRoute(
                builder: (context) => ResultPage(), context: context));
          } else {
            quizViewModel.nextQuestion();
          }
        }
      });
    });
  }

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizViewModel.getCorrectAnswer();
    if (quizViewModel.currentQuestionIndex == 9) {
      Navigator.of(context).push(CupertinoDialogRoute(
          builder: (context) => ResultPage(), context: context));
    }

    if (userAnswer == correctAnswer) {
      // user answered correct
      quizViewModel.correctAnswers++;
      startTimer();
    } else {
      // user answered false
      quizViewModel.wrongAnswers++;
      startTimer();
    }

    if (quizViewModel.currentQuestionIndex ==
        quizViewModel.questions.length - 1) {
      quizViewModel.resetQuiz();
    }
    quizViewModel.nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: const Text("True / False Quiz"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text("Start"),
                        Spacer(),
                        Text("Finish"),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: quizViewModel.currentQuestionIndex /
                          quizViewModel.questions.length,
                      backgroundColor: Colors.black12,
                      color: Colors.deepPurple,
                    ),
                  ],
                )),
            CircularProgressIndicator(
              value: timeLeft / 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20)),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      quizViewModel.getQuestion(),
                      style: questionStyle,
                      textAlign: TextAlign.center,
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        checkAnswer(true);
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green,
                        ),
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Center(
                          child: Text(
                            "True ",
                            style: trueFalseTextStyle,
                          ),
                        ))),
                TextButton(
                    onPressed: () {
                      setState(() {
                        checkAnswer(false);
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green,
                        ),
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Center(
                          child: Text(
                            "False",
                            style: trueFalseTextStyle,
                          ),
                        ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
