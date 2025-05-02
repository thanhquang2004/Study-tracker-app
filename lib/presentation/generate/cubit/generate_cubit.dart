
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_tracker_mobile/data/services/roadmap_service.dart';
import 'package:study_tracker_mobile/domain/model/quiz.dart';
import 'package:study_tracker_mobile/presentation/generate/cubit/chat_message.dart';
import 'package:study_tracker_mobile/presentation/generate/cubit/generate_model.dart';

/// Predefined first and last quiz questions
final QuizResponse firstQuestionModel = QuizResponse(
  nextQuestion: 'What do you want to learn?',
  info: 'Want to study',
  suggestAnswer: [],
);
final QuizResponse lastQuestionModel = QuizResponse(
  nextQuestion: 'How long do you want to do it?',
  info: 'Goal',
  suggestAnswer: [],
);


/// Quiz Cubit handling chat flow
class GenerateCubit extends Cubit<GenerateModel> {
  final RoadmapService _api;
  GenerateCubit(this._api) : super(GenerateModel.initial());

  Future<void> submitAnswer(String answer) async {
  final isFirst = state.pageIndex == 0;
  final newGoal = isFirst ? answer : state.goal;
  final currentQuiz = (state.pageIndex == 0)
      ? firstQuestionModel
      : (state.pageIndex == 4)
          ? lastQuestionModel
          : state.quiz;
  final info = currentQuiz.info;
  final newInfo = state.infos.isEmpty
      ? '$info: $answer'
      : '${state.infos} $info: $answer;';

  // Add user message
  final updatedMessages = List<ChatMessage>.from(state.messages)
    ..add(ChatMessage(text: answer, isUser: true));

  emit(state.copyWith(isLoading: true, error: null, messages: updatedMessages));

  try {
    if (state.pageIndex == 4) {
      // Generate roadmap after answering the last question
      final roadmap = await _api.generateRoadmap(newInfo).timeout(const Duration(minutes: 3)).then(
        (value) => value,
        onError: (error, stackTrace) {
          throw Exception('Error generating roadmap: $error');
        },
      );
      updatedMessages.add(ChatMessage(text: 'Here is your roadmap!', isUser: false));
      emit(state.copyWith(
        isLoading: false,
        roadmap: roadmap,
        messages: updatedMessages,
      ));
    } else {
      // Next quiz
      final req = QuizRequest(goal: newGoal, info: newInfo);
      final quiz = (state.pageIndex + 1 == 4) ? lastQuestionModel : await _api.generateQuiz(req);
      updatedMessages.add(ChatMessage(text: quiz.nextQuestion, isUser: false));
      emit(state.copyWith(
        isLoading: false,
        quiz: quiz,
        goal: newGoal,
        infos: newInfo,
        pageIndex: state.pageIndex + 1,
        messages: updatedMessages,
      ));
    }
    state.scrollController.jumpTo(state.scrollController.position.maxScrollExtent);
  } catch (e) {
    updatedMessages.add(ChatMessage(text: 'Server has error, Please try again', isUser: false));
    emit(state.copyWith(isLoading: false, error: e.toString()));
  }
}
}
