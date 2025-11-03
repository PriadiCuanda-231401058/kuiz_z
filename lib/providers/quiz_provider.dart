import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuizProvider extends ChangeNotifier {
  final List<Question> _questions = [
    Question('Ibukota Indonesia?', ['Jakarta', 'Medan', 'Bandung', 'Surabaya'], 0),
    Question('2 + 2 = ?', ['3', '4', '5', '6'], 1),
    Question('Warna bendera Indonesia?', ['Merah Putih', 'Hijau Putih', 'Biru Kuning', 'Putih Merah'], 0),
  ];

  int currentIndex = 0;
  int score = 0;

  List<Question> get questions => _questions;

  void answerQuestion(int selectedIndex) {
    if (_questions[currentIndex].answerIndex == selectedIndex) {
      score++;
    }
    if (currentIndex < _questions.length - 1) {
      currentIndex++;
    }
    notifyListeners();
  }

  void resetQuiz() {
    currentIndex = 0;
    score = 0;
    notifyListeners();
  }

  void nextQuestion() {
    if (currentIndex < _questions.length - 1) {
      currentIndex++;
    }
    notifyListeners();
  }
}
