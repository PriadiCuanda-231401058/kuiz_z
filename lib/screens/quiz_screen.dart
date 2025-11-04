import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/question_card.dart';
import '../providers/theme_provider.dart';
import 'package:kuizz/models/question_model.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String userName;
  const QuizScreen({super.key, required this.userName});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedOption;

  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<QuizProvider>(context);
    final size = MediaQuery.of(context).size;
    final question = quiz.questions[quiz.currentIndex];
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isPortrait = size.height > size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kuizz App',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isPortrait ? size.width * 0.05 : size.width * 0.03,
            vertical: isPortrait ? size.height * 0.02 : size.height * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section - lebih kompak di landscape
              _buildHeaderSection(size, isPortrait),
              
              SizedBox(height: isPortrait ? 20 : 10),

              // Progress Section
              _buildProgressSection(quiz, size, isPortrait),

              SizedBox(height: isPortrait ? 30 : 15),

              // Question dan Options dalam layout yang berbeda untuk landscape
              if (isPortrait) 
                _buildPortraitLayout(question, size, quiz)
              else 
                _buildLandscapeLayout(question, size, quiz),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(Question question, Size size, QuizProvider quiz) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Section
          _buildQuestionSection(question, size, true),
          const SizedBox(height: 25),
          // Options Section
          Expanded(
            child: QuestionCard(
              question: question.question,
              options: question.options,
              selectedOption: selectedOption,
              onOptionSelected: (index) {
                setState(() {
                  selectedOption = index;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          // Next Button
          _buildNextButton(quiz, size, true),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout(Question question, Size size, QuizProvider quiz) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question di sebelah kiri
          Expanded(
            flex: 1,
            child: Column(
              children: [
                _buildQuestionSection(question, size, false),
                const Spacer(),
                _buildNextButton(quiz, size, false),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Options di sebelah kanan
          Expanded(
            flex: 1,
            child: QuestionCard(
              question: question.question,
              options: question.options,
              selectedOption: selectedOption,
              onOptionSelected: (index) {
                setState(() {
                  selectedOption = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(Size size, bool isPortrait) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back,",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: isPortrait ? size.width * 0.04 : size.height * 0.025,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
            Text(
              widget.userName,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: isPortrait ? size.width * 0.06 : size.height * 0.03,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(isPortrait ? 12 : 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.quiz_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: isPortrait ? size.width * 0.07 : size.height * 0.04,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection(QuizProvider quiz, Size size, bool isPortrait) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Progress",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: isPortrait ? size.width * 0.04 : size.height * 0.025,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "${quiz.currentIndex + 1}/${quiz.questions.length}",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: isPortrait ? size.width * 0.04 : size.height * 0.025,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: isPortrait ? 10 : 5),
        LinearProgressIndicator(
          value: (quiz.currentIndex + 1) / quiz.questions.length,
          backgroundColor: Colors.grey[300],
          color: Theme.of(context).colorScheme.primary,
          minHeight: 8,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }

  Widget _buildQuestionSection(Question question, Size size, bool isPortrait) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isPortrait ? 20 : 15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.help_outline,
                color: Theme.of(context).colorScheme.primary,
                size: isPortrait ? size.width * 0.05 : size.height * 0.025,
              ),
              SizedBox(width: 8),
              Text(
                "Question",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: isPortrait ? size.width * 0.04 : size.height * 0.022,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: isPortrait ? 12 : 8),
          Text(
            question.question,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: isPortrait ? size.width * 0.045 : size.height * 0.025,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton(QuizProvider quiz, Size size, bool isPortrait) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: selectedOption != null
            ? () {
                quiz.answerQuestion(selectedOption!);
                final isLast = quiz.currentIndex == quiz.questions.length - 1;
                if (isLast) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResultScreen(name: widget.userName),
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
          backgroundColor: selectedOption != null
              ? Theme.of(context).colorScheme.primary
              : Colors.grey[400],
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: isPortrait ? size.height * 0.02 : size.height * 0.015,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
          shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              quiz.currentIndex == quiz.questions.length - 1
                  ? "See Results"
                  : "Next Question",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: isPortrait ? size.width * 0.045 : size.height * 0.02,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              quiz.currentIndex == quiz.questions.length - 1
                  ? Icons.emoji_events_outlined
                  : Icons.arrow_forward_rounded,
              size: isPortrait ? size.width * 0.05 : size.height * 0.025,
            ),
          ],
        ),
      ),
    );
  }
}