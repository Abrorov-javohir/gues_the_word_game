import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gues_the_word_game/controller/question_controller.dart';
import 'dart:math';

import 'package:gues_the_word_game/view/screens/question_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final QuestionController questionController = Get.find<QuestionController>();
  late List<String> shuffledLetters;
  late List<String?> placedLetters;

  @override
  void initState() {
    super.initState();
    loadQuestion();
  }

  void loadQuestion() {
    final question = questionController.questions.isNotEmpty
        ? questionController.questions.first.name
        : "";
    shuffledLetters = question.characters.toList()..shuffle(Random());
    placedLetters = List<String?>.filled(question.length, null);
  }

  void checkCompletion() {
    if (placedLetters.every((letter) => letter != null)) {
      Get.defaultDialog(
        title: "Congratulations!",
        middleText: "You have found the word!",
        confirm: ElevatedButton(
          onPressed: () {
            loadQuestion();
            Get.to(QuestionScreen());
          },
          child: Text("Next"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://i.pinimg.com/originals/be/36/d3/be36d333a6ec650a9c0d663399b83f24.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50), // Add spacing from the top
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Image.asset(
                      "assets/rectangle.png",
                      width: 118,
                      height: 38,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/star.png",
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(
                            width: 4), // Spacing between icon and text
                        const Text(
                          '0',
                          style: TextStyle(
                              fontSize: 20, color: Colors.black), // Add color
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/romp.png",
                      width: 104,
                      height: 79,
                    ),
                    const Text(
                      '1',
                      style: TextStyle(
                          fontSize: 24, color: Colors.black), // Add styling
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Image.asset(
                      "assets/rectangle.png",
                      width: 120,
                      height: 40,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/diamond.png",
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(
                            width: 4), // Spacing between icon and text
                        const Text(
                          '50',
                          style: TextStyle(
                              fontSize: 20, color: Colors.black), // Add color
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20), // Add spacing between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.defaultDialog(
                        title: "Help",
                        middleText:
                            "U can use for help to find this word\n+998 90 062 09 10\n call this number and this person can help with your problem");
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/idea.png",
                          width: 15,
                          height: 26,
                        ),
                        const Positioned(
                          top: -5, // Adjust the position to place it on top
                          right: -5,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add,
                              size: 15,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.defaultDialog(
                        title: "Diamond",
                        middleText:
                            "U can use diamond for buying new product.\n New product can add soon!");
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/diamond.png",
                          width: 15,
                          height: 26,
                        ),
                        const Positioned(
                          top: -5, // Adjust the position to place it on top
                          right: -5,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add,
                              size: 15,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // DragTarget to place letters
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: List.generate(placedLetters.length, (index) {
                return DragTarget<String>(
                  onAccept: (data) {
                    setState(() {
                      // Place the letter only if the correct one
                      if (questionController.questions.isNotEmpty &&
                          data ==
                              questionController.questions.first.name[index]) {
                        placedLetters[index] = data;
                        shuffledLetters.remove(data); // Remove the letter
                        checkCompletion(); // Check if the word is complete
                      }
                    });
                  },
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Container(
                      width: 40,
                      height: 40,
                      color: placedLetters[index] != null
                          ? Colors.green
                          : Colors.red,
                      child: Center(
                        child: Text(
                          placedLetters[index] ?? '',
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 20),
            // Draggable letters
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: List.generate(
                shuffledLetters.length,
                (index) {
                  final char = shuffledLetters[index];
                  return Draggable<String>(
                    data: char,
                    feedback: Material(
                      child: Container(
                        width: 40,
                        height: 40,
                        color: Colors.blue,
                        child: Center(
                          child: Text(
                            char,
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    childWhenDragging: Container(
                      width: 40,
                      height: 40,
                      color: Colors.blue.withOpacity(0.5),
                      child: Center(
                        child: Text(
                          char,
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          char,
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
