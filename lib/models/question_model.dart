import 'dart:convert';

// Represents a question with its corresponding answer.
class QuestionModel {
  final String question; // The question text.
  final String answer; // The correct answer to the question.

  QuestionModel({
    required this.question, // Both question and answer are required.
    required this.answer,
  });

  // Creates a QuestionModel object from a JSON map.
  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    // Ensures the required keys exist in the JSON data.
    assert(json.containsKey('question'), 'Missing "question" key in JSON.');
    assert(json.containsKey('answer'), 'Missing "answer" key in JSON.');

    return QuestionModel(
      question: json['question'] as String, // Casts fetched values to their types.
      answer: json['answer'] as String,
    );
  }
}

// Loads a list of QuestionModel objects from a JSON string.
List<QuestionModel> loadQuestionsFromJson(String jsonString) {
  final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
  return jsonList.map((json) => QuestionModel.fromJson(json)).toList();
}
