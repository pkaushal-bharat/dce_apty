import 'package:flutter/material.dart';

class AnimatedFeedback extends StatelessWidget {
  final String correctAnswer;
  final bool isCorrect;

  const AnimatedFeedback(
      {Key? key, required this.correctAnswer, required this.isCorrect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: 1,
      child: Column(
        children: [
          Text(
            isCorrect ? 'Correct!' : 'Incorrect!',
            style: TextStyle(
                color: isCorrect ? Colors.green : Colors.red, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            'The correct answer is: $correctAnswer',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
