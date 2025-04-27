class QuizRequest {
  final String goal;
  final String info;

  QuizRequest({
    required this.goal,
    required this.info,
  });

  Map<String, dynamic> toJson() {
    return {
      'goal': goal,
      'info': info,
    };
  }
}

class QuizResponse {
  final String nextQuestion;
  final String info;
  final List<SuggestAnswer> suggestAnswer;

  QuizResponse({
    required this.nextQuestion,
    required this.info,
    required this.suggestAnswer,
  });

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      nextQuestion: json['nextQuestion'] as String,
      info: json['info'] as String,
      suggestAnswer: (json['suggestAnswer'] as List<dynamic>)
          .map((e) => SuggestAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nextQuestion': nextQuestion,
      'info': info,
      'suggestAnswer': suggestAnswer.map((e) => e.toJson()).toList(),
    };
  }
}

class SuggestAnswer {
  final String content;

  SuggestAnswer({required this.content});

  factory SuggestAnswer.fromJson(Map<String, dynamic> json) {
    return SuggestAnswer(
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
    };
  }
}
