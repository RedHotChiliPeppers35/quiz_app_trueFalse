import '../Model/questionModel.dart';

class QuizViewModel {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  List<Question> questions = [
    Question(
        question: "The capital city of Australia is Sydney.", answer: false),
    Question(
        question:
            "The process of photosynthesis converts carbon dioxide and water into glucose and oxygen.",
        answer: true),
    Question(
        question:
            "The Great Wall of China was primarily built during the Ming Dynasty.",
        answer: true),
    Question(
        question:
            "In the English language, 'i before e except after c' is a rule without any exceptions.",
        answer: false),
    Question(question: "A light year is a unit of time.", answer: false),
    Question(
        question:
            "The human body has four chambers in its heart: two atria and two ventricles.",
        answer: true),
    Question(question: "Helium has an atomic number of 3.", answer: false),
    Question(
        question: "The Amazon River is the longest river in the world.",
        answer: false),
    Question(question: "A byte is composed of 8 bits.", answer: true),
    Question(
        question:
            "The first human-made object to land on the moon was Apollo 11 in 1969.",
        answer: true),
  ];

  String getQuestion() {
    return questions[currentQuestionIndex].question;
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
    }
  }

  void resetQuiz() {
    currentQuestionIndex = -1;
  }

  bool getCorrectAnswer() {
    return questions[currentQuestionIndex].answer;
  }
}
