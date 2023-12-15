import 'package:dce_apty/widgets/animated_feedback.dart';
import 'package:dce_apty/widgets/animated_next_question_btn.dart';
import 'package:flutter/material.dart';

class FeedbackAndNextButtonWidget extends StatelessWidget {
  final String correctAnswer;
  final bool isCorrect;
  final Function() nextQuestion;
  final bool showCorrectAnswer;

  const FeedbackAndNextButtonWidget({
    Key? key,
    required this.correctAnswer,
    required this.isCorrect,
    required this.nextQuestion,
    required this.showCorrectAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          if (showCorrectAnswer)
            AnimatedFeedback(
                correctAnswer: correctAnswer, isCorrect: isCorrect),
          const SizedBox(height: 20),
          AnimatedNextQuestionButton(
            onPressed: nextQuestion,
            isVisible: showCorrectAnswer,
          ),
        ],
      ),
    );
  }
}
