
import 'package:dce_apty/models/question_model.dart';
import 'package:dce_apty/screens/aptitude_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load JSON file from assets
  final jsonString = await rootBundle.loadString('assets/questions.json');

  // Parse JSON and get a list of QuestionModel
  final List<QuestionModel> questions = loadQuestionsFromJson(jsonString);

  // Now you can use the 'questions' list in your app
  print(questions.length);
  runApp(MaterialApp(
      title: 'APTi Practice',
      theme: appTheme,
      home: AptitudeScreen(questions: questions),
    ));
}

