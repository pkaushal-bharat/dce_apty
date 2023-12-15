import 'package:dce_apty/models/question_model.dart';
import 'package:dce_apty/widgets/animated_answer_textfield.dart';
import 'package:dce_apty/widgets/animated_check_answer_btn.dart';
import 'package:dce_apty/widgets/animated_question_text.dart';
import 'package:flutter/material.dart';

class QuestionAndAnswerWidget extends StatelessWidget {
  final QuestionModel question;
  final TextEditingController answerController;
  final Function() checkAnswer;
  final bool showCorrectAnswer;

  const QuestionAndAnswerWidget({
    Key? key,
    required this.question,
    required this.answerController,
    required this.checkAnswer,
    required this.showCorrectAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedQuestionText(question: question.question),
        AnimatedAnswerTextField(controller: answerController),
        AnimatedCheckAnswerButton(
          onPressed: checkAnswer,
          isVisible: !showCorrectAnswer,
        ),
      ],
    );
  }
}
