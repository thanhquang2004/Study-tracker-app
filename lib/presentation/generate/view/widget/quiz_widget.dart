
import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/domain/model/roadmap.dart';

class QuizWidget extends StatelessWidget {
  final Quiz quiz;

  const QuizWidget({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Question: ${quiz.question}'),
          Text('Answer: ${quiz.answer}'),
          if (quiz.options.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: quiz.options
                  .map((option) => Text('Option: $option'))
                  .toList(),
            ),
        ],
      ),
    );
  }
}