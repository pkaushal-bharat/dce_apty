import 'dart:convert';

class QuestionModel {
  final String question;
  final String answer;

  QuestionModel({
    required this.question,
    required this.answer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'] as String,
      answer: json['answer'] as String,
    );
  }
}

List<QuestionModel> loadQuestionsFromJson(String jsonString) {
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((json) => QuestionModel.fromJson(json)).toList();
}
