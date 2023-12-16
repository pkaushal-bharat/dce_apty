import 'dart:async';
import 'dart:math';

import 'package:dce_apty/widgets/animated_answer_textfield.dart';
import 'package:dce_apty/widgets/animated_next_question_btn.dart';
import 'package:dce_apty/widgets/animated_question_text.dart';
import 'package:dce_apty/widgets/top_stats_infobar.dart';
import 'package:flutter/material.dart';
import 'package:dce_apty/models/question_model.dart';

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
        title: Text('Aptitude Question: $questionCount'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => _showDeveloperInfo(context),
          ),
        ],
      ),
      body: buildQuestionBody(currentQuestion),
    );
  }

  Widget buildQuestionBody(QuestionModel currentQuestion) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TopStatsBar(
            totalTimeInSeconds: totalTimeInSeconds,
            correctAnswersCount: correctAnswersCount,
            timeSpentOnCurrentQuestion: timeSpentOnCurrentQuestion,
          ),
          AnimatedQuestionText(question: currentQuestion.question),
          Row(
            children: [
              Expanded(
                child: AnimatedAnswerTextField(controller: answerController),
              ),
              const SizedBox(width: 8), // Adjust spacing between elements
              AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  opacity: 1,
                  child: showCorrectAnswer
                      ? Text(
                          isCorrect ? 'Correct!' : 'Incorrect!',
                          style: TextStyle(
                              color: isCorrect ? Colors.green : Colors.red,
                              fontSize: 20),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (answerController.text.isNotEmpty) {
                              checkAnswer();
                            }
                          },
                          child: const Text('Check Answer'),
                        )),
            ],
          ),
          const SizedBox(height: 8),
          if (showCorrectAnswer)
            Text(
              'The correct answer is: ${currentQuestion.answer}',
              style: const TextStyle(fontSize: 16),
            ),
          const SizedBox(height: 8),
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

  void _showDeveloperInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AboutDialog(
        children: [
          const CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage('assets/pkaush.jpg'),
          ),
          const SizedBox(height: 8),
          Text('Prakash Kaushal',
              style: Theme.of(context).textTheme.titleLarge),
          const Text('pkaushal41119@gmail.com'),
          InkWell(
            onTap: () => print('Opening LinkedIn profile'),
            child: const Text(
              'linkedin.com/in/prakasa-k',
              style: TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}
