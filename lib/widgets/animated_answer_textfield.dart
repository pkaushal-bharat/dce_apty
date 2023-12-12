import 'package:flutter/material.dart';

class AnimatedAnswerTextField extends StatelessWidget {
  final TextEditingController controller;

  const AnimatedAnswerTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: 1,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'Your Answer'),
      ),
    );
  }
}