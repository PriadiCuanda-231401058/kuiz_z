import 'package:flutter/material.dart';
import 'package:kuizz/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_provider.dart';
// import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kuis Pilihan Ganda',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.indigo,
      ),
      home: const SplashScreen(),
    );
  }
}
