import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gues_the_word_game/controller/question_controller.dart';
import 'home_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final QuestionController questionController = Get.put(QuestionController());
  final TextEditingController questionTextController = TextEditingController();

  void showAddQuestionDialog() {
    Get.defaultDialog(
      title: "Add Question",
      content: Column(
        children: [
          TextField(
            controller: questionTextController,
            decoration: InputDecoration(
              labelText: "Question",
            ),
          ),
          SizedBox(height: 10),
          FilledButton(
            onPressed: () {
              if (questionTextController.text.isNotEmpty) {
                questionController.addQuestion(questionTextController.text);
                questionTextController.clear();
                Get.back();
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  void startGame() {
    Get.to(() => HomeScreen());
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
          children: [
            Expanded(
              child: Obx(
                () {
                  return ListView.builder(
                    itemCount: questionController.questions.length,
                    itemBuilder: (context, index) {
                      final question = questionController.questions[index];
                      return ListTile(
                        title: Text(question.name),
                        subtitle: Text('ID: ${question.id}'),
                      );
                    },
                  );
                },
              ),
            ),
            FilledButton(
              onPressed: showAddQuestionDialog,
              child: const Text("Add questions"),
            ),
            FilledButton(
              onPressed: startGame,
              child: const Text("Start"),
            ),
          ],
        ),
      ),
    );
  }
}
