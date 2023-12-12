import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dce_apty/models/question_model.dart';
import 'package:dce_apty/widgets/animated_answer_textfield.dart';
import 'package:dce_apty/widgets/animated_check_answer_btn.dart';
import 'package:dce_apty/widgets/animated_feedback.dart';
import 'package:dce_apty/widgets/animated_next_question_btn.dart';
import 'package:dce_apty/widgets/animated_question_text.dart';

class AptitudeScreen extends StatefulWidget {
  final List<QuestionModel> questions;

  const AptitudeScreen({Key? key, required this.questions}) : super(key: key);

  @override
  _AptitudeScreenState createState() => _AptitudeScreenState();
}

class _AptitudeScreenState extends State<AptitudeScreen> {
  int questionCount = 1;
  int currentQuestionIndex = 0;
  int correctAnswersCount = 0;
  TextEditingController answerController = TextEditingController();
  bool isCorrect = false;
  bool showCorrectAnswer = false;

  late Timer _timer;
  int totalTimeInSeconds = 0; // Total time in seconds
  int timeSpentOnCurrentQuestion = 0; // Time on the current question in seconds

  @override
  void initState() {
    super.initState();
    _startTimer();
    initializeRandomIndex();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        totalTimeInSeconds++;
        timeSpentOnCurrentQuestion++;
      });
    });
  }

  void initializeRandomIndex() {
    final random = Random();
    currentQuestionIndex = random.nextInt(widget.questions.length);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void checkAnswer() {
    final currentQuestion = widget.questions[currentQuestionIndex];
    final userAnswer = answerController.text.trim();
    final userNumericAnswer = extractNumericValues(userAnswer);

    setState(() {
      isCorrect =
          extractNumericValues(currentQuestion.answer) == userNumericAnswer;
      showCorrectAnswer = true;
      if (isCorrect) {
        correctAnswersCount++;
      }
    });
  }

  String extractNumericValues(String input) {
    final RegExp regex = RegExp(r'\d+');
    final List<Match> matches = regex.allMatches(input).toList();
    final List<String> numericValues =
        matches.map((match) => match.group(0)!).toList();
    return numericValues.join('');
  }

  void nextQuestion() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        questionCount++;
        currentQuestionIndex++;
        isCorrect = false;
        showCorrectAnswer = false;
        answerController.clear();
        timeSpentOnCurrentQuestion = 0;
        widget.questions.shuffle();
      });
    } else {
      currentQuestionIndex = 0;
      // Handle end of questions
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Aptitude Question $questionCount'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => _showDeveloperInfo(context),
          ),
        ],
      ),
      body: buildQuestionBody(currentQuestion),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildQuestionBody(QuestionModel currentQuestion) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedQuestionText(question: currentQuestion.question),
          const SizedBox(height: 20),
          AnimatedAnswerTextField(controller: answerController),
          const SizedBox(height: 20),
          AnimatedCheckAnswerButton(
            onPressed: () {
              if (answerController.text.isNotEmpty) {
                checkAnswer();
              }
            },
            isVisible: !showCorrectAnswer,
          ),
          const SizedBox(height: 20),
          if (showCorrectAnswer)
            AnimatedFeedback(
                correctAnswer: currentQuestion.answer, isCorrect: isCorrect),
          const SizedBox(height: 20),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedNextQuestionButton(
                onPressed: nextQuestion,
                isVisible: showCorrectAnswer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Display total time on the left
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Total Time Spent: ${formatTime(totalTimeInSeconds)}"),
          ),
          ElevatedButton(
            onPressed: null,
            child: Text("Correct Answers: $correctAnswersCount"),
          ),
          // Display time spent on the current question on the right
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "This Question : ${formatTime(timeSpentOnCurrentQuestion)}"),
          ),
        ],
      ),
    );
  }

  String formatTime(int seconds) {
    // Format the time in HH:MM:SS
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$hours:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _showDeveloperInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Developer Information'),
          content: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/pkaush.png'), // Replace with your image asset
              ),
              const SizedBox(height: 10),
              const Text('Developer: Prakash Kaushal'),
              const Text('Email: pkaushal41119@gmail.com'),
              GestureDetector(
                onTap: () {
                  // Launch LinkedIn profile in a browser or LinkedIn app
                  // You may need to use a package like 'url_launcher' for this
                  print("Opening LinkedIn profile");
                },
                child: const Text(
                  'LinkedIn: linkedin.com/in/prakasa-k',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              // Add more details as needed
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
