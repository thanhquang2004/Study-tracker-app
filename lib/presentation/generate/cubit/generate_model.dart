
import 'package:flutter/widgets.dart';
import 'package:study_tracker_mobile/domain/model/quiz.dart';
import 'package:study_tracker_mobile/domain/model/roadmap.dart';
import 'package:study_tracker_mobile/presentation/generate/cubit/chat_message.dart';
import 'package:study_tracker_mobile/presentation/generate/cubit/generate_cubit.dart';

/// Quiz State with chat messages
class GenerateModel {
  final int pageIndex;
  final String goal;
  final String infos;
  final bool isLoading;
  final QuizResponse quiz;
  final RoadmapResponse? roadmap;
  final String? error;
  final List<ChatMessage> messages;
  final ScrollController scrollController;

  GenerateModel({
    required this.pageIndex,
    required this.goal,
    required this.infos,
    required this.isLoading,
    required this.quiz,
    this.roadmap,
    this.error,
    required this.messages,
    required this.scrollController,
  });

  factory GenerateModel.initial() {
    return GenerateModel(
      pageIndex: 0,
      goal: '',
      infos: '',
      isLoading: false,
      error: null,
      quiz: firstQuestionModel,
      roadmap: null,
      messages: [ChatMessage(text: firstQuestionModel.nextQuestion, isUser: false)],
      scrollController: ScrollController(),
    );
  }

  GenerateModel copyWith({
    int? pageIndex,
    String? goal,
    String? infos,
    bool? isLoading,
    QuizResponse? quiz,
    RoadmapResponse? roadmap,
    String? error,
    List<ChatMessage>? messages,
    ScrollController? scrollController,
  }) {
    return GenerateModel(
      pageIndex: pageIndex ?? this.pageIndex,
      goal: goal ?? this.goal,
      infos: infos ?? this.infos,
      isLoading: isLoading ?? this.isLoading,
      quiz: quiz ?? this.quiz,
      roadmap: roadmap ?? this.roadmap,
      error: error,
      messages: messages ?? this.messages,
      scrollController: scrollController ?? this.scrollController, // Keep the same scroll controller
    );
  }
}