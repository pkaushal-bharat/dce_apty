import 'package:flutter/material.dart';

class AnimatedNextQuestionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isVisible;

  const AnimatedNextQuestionButton(
      {Key? key, required this.onPressed, required this.isVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: isVisible ? 1 : 0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => Colors.blue,
          ),
        ),
        child: const Text('Next Question'),
      ),
    );
  }
}
