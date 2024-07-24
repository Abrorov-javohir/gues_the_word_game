import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gues_the_word_game/view/screens/home_screen.dart';
import 'package:gues_the_word_game/view/screens/question_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuestionScreen(),
    );
  }
}
