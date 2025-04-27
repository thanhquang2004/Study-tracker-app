import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:study_tracker_mobile/data/config/api_service.dart';
import 'package:study_tracker_mobile/domain/model/quiz.dart';
import 'package:study_tracker_mobile/domain/model/roadmap.dart';
import 'package:study_tracker_mobile/domain/repository/roadmap_repository.dart';
import 'package:study_tracker_mobile/presentation/resources/api_manager.dart';

class RoadmapService extends RoadmapRepository{

  final _api = GetIt.instance<ApiService>();


  @override
  Future<QuizResponse> generateQuiz(QuizRequest quizRequest) async {
    try {
      final response = await _api.post(ApiManager.generateQuiz, data: quizRequest.toJson());
      return QuizResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('Error generating quiz: ${e.message}');
      rethrow;
    }

  }

  @override
  Future<RoadmapResponse> generateRoadmap(String promtData) async {
    try {
      final response = await _api.post(ApiManager.generateRoadmap, data: {"info": promtData});
      return RoadmapResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('Error generating roadmap: ${e.message}');
      rethrow;
    }
  }

}