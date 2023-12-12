import 'package:flutter/material.dart';

class AnimatedQuestionText extends StatelessWidget {
  final String question;

  const AnimatedQuestionText({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: 1,
      child: Text(
        question,
        style: const TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}
