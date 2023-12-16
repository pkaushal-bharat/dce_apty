import 'package:flutter/material.dart';

class TopStatsBar extends StatelessWidget {
  final int totalTimeInSeconds;
  final int correctAnswersCount;
  final int timeSpentOnCurrentQuestion;

  const TopStatsBar({
    Key? key,
    required this.totalTimeInSeconds,
    required this.correctAnswersCount,
    required this.timeSpentOnCurrentQuestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Display time spent on the current question on the right
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Correct: $correctAnswersCount"),
          ),
          ElevatedButton(
            onPressed: null,
            child: Text(formatTime(timeSpentOnCurrentQuestion)),
          ),
          // Display total time on the left
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Total: ${formatTime(totalTimeInSeconds)}"),
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
}
