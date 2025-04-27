
import 'package:study_tracker_mobile/domain/model/quiz.dart';
import 'package:study_tracker_mobile/domain/model/roadmap.dart';

abstract class RoadmapRepository {
  Future<QuizResponse> generateQuiz(QuizRequest quizRequest);
  Future<RoadmapResponse> generateRoadmap(String promtData);
  
}