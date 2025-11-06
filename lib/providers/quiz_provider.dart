import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuizProvider extends ChangeNotifier {
  final List<Question> _questions = [
    Question('Ibukota Indonesia?', ['Jakarta', 'Medan', 'Bandung', 'Surabaya'], 0),
    Question('2 + 2 = ?', ['3', '4', '5', '6'], 1),
    Question('Warna bendera Indonesia?', ['Merah Putih', 'Hijau Putih', 'Biru Kuning', 'Putih Merah'], 0),
    Question('Siapa presiden pertama Indonesia?', ['Soekarno', 'Soeharto', 'Hatta Mohamad', 'Joko Widodo'], 0),
    Question('Apa nama ibukota provinsi Jawa Barat?', ['Jakarta', 'Bandung', 'Semarang', 'Yogyakarta'], 1),
  ];

  int currentIndex = 0;
  int score = 0;

  List<Question> get questions => _questions;

  void answerQuestion(int selectedIndex) {
    if (_questions[currentIndex].answerIndex == selectedIndex) {
      score++;
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
