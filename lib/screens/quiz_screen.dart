import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/question_card.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String userName;
  const QuizScreen({super.key, required this.userName});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedOption; // simpan index opsi yang dipilih

  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<QuizProvider>(context);
    final size = MediaQuery.of(context).size;
    final question = quiz.questions[quiz.currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "Halo, ${widget.userName}!",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6A11CB),
                ),
              ),
              const SizedBox(height: 15),

              // Progress bar
              LinearProgressIndicator(
                value: (quiz.currentIndex + 1) / quiz.questions.length,
                backgroundColor: Colors.grey[300],
                color: const Color(0xFF6A11CB),
                minHeight: 8,
              ),
              const SizedBox(height: 25),

              // Pertanyaan
              Text(
                question.question,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2575FC),
                ),
              ),
              const SizedBox(height: 20),

              // Opsi jawaban dengan dot interaktif
              QuestionCard(
                question: question.question,
                options: question.options,
                selectedOption: selectedOption,
                onOptionSelected: (index) {
                  setState(() {
                    selectedOption = index;
                  });
                  quiz.answerQuestion(index);
                },
              ),
              const Spacer(),

              // Tombol Next
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: selectedOption != null
                      ? () {
                          final isLast = quiz.currentIndex == quiz.questions.length - 1;
                          if (isLast) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ResultScreen(name: widget.userName),
                              ),
                            );
                          } else {
                            setState(() {
                              selectedOption = null;
                            });
                            quiz.nextQuestion();
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A11CB),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
