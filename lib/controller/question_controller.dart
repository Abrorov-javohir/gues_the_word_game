import 'package:get/get.dart';
import 'package:gues_the_word_game/model/question.dart';

class QuestionController extends GetxController {
  // Define an observable list of questions using RxList
  var questions = <Question>[].obs;

  // Method to add a question to the list
  void addQuestion(String name) {
    final newQuestion = Question(
      name: name,
      id: questions.length + 1,
    );
    questions.add(newQuestion);
  }

  // Method to remove a question from the list
  void removeQuestion(Question question) {
    questions.remove(question);
  }

  // Method to get a question by ID
  Question? getQuestionById(int id) {
    return questions.firstWhereOrNull((question) => question.id == id);
  }
}
