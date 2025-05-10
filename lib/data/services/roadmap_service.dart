import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:study_tracker_mobile/data/config/api_service.dart';
import 'package:study_tracker_mobile/domain/model/quiz.dart';
import 'package:study_tracker_mobile/domain/model/roadmap.dart';
import 'package:study_tracker_mobile/domain/repository/roadmap_repository.dart';
import 'package:study_tracker_mobile/presentation/resources/api_manager.dart';

class RoadmapService extends RoadmapRepository {
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
      // return RoadmapResponse.fromJson(roadmapData);
    } on DioException catch (e) {
      print('Error generating roadmap: ${e.message}');
      rethrow;
    }
  }
}

final Map<String, dynamic> roadmapData = {
  "stages": [
    {
      "name": "Stage 1: Fundamental Drawing Skills",
      "timeframe": "2 months",
      "tasks": [
        {
          "name": "Task 1: Basic Shapes and Forms",
          "description": "Learn to draw basic shapes and forms, the foundation of any drawing.",
          "time": "2 weeks",
          "subtasks": [
            {
              "name": "Subtask 1: Lines and Contours",
              "description": "Practice drawing various types of lines and contours.",
              "time": "3 days",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": [
                {
                  "question": "What is a contour line?",
                  "answer": "A line that defines the edges and curves of an object",
                  "options": [
                    "A line that defines the edges and curves of an object",
                    "A line that shows the direction of light",
                    "A line that creates shading",
                    "A line that represents movement"
                  ]
                },
                {
                  "question": "What is a blind contour drawing?",
                  "answer": "Drawing without looking at the paper",
                  "options": [
                    "Drawing without looking at the paper",
                    "Drawing with your eyes closed",
                    "Drawing from memory",
                    "Drawing with a single continuous line"
                  ]
                },
                {
                  "question": "What is cross-contour drawing?",
                  "answer": "Drawing lines that follow the curves and form of the subject",
                  "options": [
                    "Drawing lines that follow the curves and form of the subject",
                    "Drawing lines that intersect each other",
                    "Drawing lines that create shading",
                    "Drawing lines that represent movement"
                  ]
                },
                {
                  "question": "What is a gesture drawing?",
                  "answer": "A quick sketch that captures the essence of a pose or movement",
                  "options": [
                    "A quick sketch that captures the essence of a pose or movement",
                    "A detailed drawing of a stationary object",
                    "A drawing that focuses on light and shadow",
                    "A drawing that uses color to create mood"
                  ]
                },
                {
                  "question": "What is the purpose of practicing line variations?",
                  "answer": "All of the above",
                  "options": [
                    "To create visual interest and depth in a drawing",
                    "To make the drawing look more realistic",
                    "To improve hand-eye coordination",
                    "All of the above"
                  ]
                }
              ]
            },
            {
              "name": "Subtask 2: Cubes and Rectangular Prisms",
              "description":
                  "Practice drawing cubes and rectangular prisms in different perspectives.",
              "time": "4 days",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 3: Spheres and Cylinders",
              "description": "Practice drawing spheres and cylinders in different perspectives.",
              "time": "3 days",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            }
          ]
        },
        {
          "name": "Task 2: Light and Shadow",
          "description": "Learn how light and shadow affect the appearance of forms.",
          "time": "2 weeks",
          "subtasks": [
            {
              "name": "Subtask 1: Understanding Light Sources",
              "description": "Learn about different types of light sources and their effects.",
              "time": "3 days",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 2: Shading Techniques",
              "description":
                  "Practice different shading techniques like hatching, cross-hatching, and blending.",
              "time": "4 days",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 3: Creating Depth and Form with Shading",
              "description":
                  "Apply shading to create the illusion of depth and three-dimensionality.",
              "time": "3 days",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            }
          ]
        },
        {
          "name": "Task 3: Perspective Drawing",
          "description": "Learn the basics of perspective to create depth in your drawings.",
          "time": "2 weeks",
          "subtasks": [
            {
              "name": "Subtask 1: One-Point Perspective",
              "description": "Practice drawing objects in one-point perspective.",
              "time": "3 days",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 2: Two-Point Perspective",
              "description": "Practice drawing objects in two-point perspective.",
              "time": "4 days",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 3: Applying Perspective to Simple Objects",
              "description": "Draw everyday objects using perspective principles.",
              "time": "3 days",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            }
          ]
        }
      ]
    },
    {
      "name": "Stage 2: Introduction to Anatomy Drawing",
      "timeframe": "3 months",
      "tasks": [
        {
          "name": "Task 1: Skeletal Structure",
          "description": "Learn the basic skeletal structure of the human body.",
          "time": "4 weeks",
          "subtasks": [
            {
              "name": "Subtask 1: Major Bones and Joints",
              "description": "Identify and draw the major bones and joints of the body.",
              "time": "1 week",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 2: Proportions of the Skeleton",
              "description":
                  "Understand and practice drawing the proportions of the human skeleton.",
              "time": "2 weeks",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 3: Skeleton in Different Poses",
              "description": "Practice drawing the skeleton in various dynamic poses.",
              "time": "1 week",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            }
          ]
        },
        {
          "name": "Task 2: Muscle Groups",
          "description": "Learn the major muscle groups of the human body.",
          "time": "4 weeks",
          "subtasks": [
            {
              "name": "Subtask 1: Identifying Major Muscle Groups",
              "description": "Identify and draw the major muscle groups of the body.",
              "time": "1 week",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 2: Muscles and Their Function",
              "description":
                  "Understand how different muscle groups contribute to movement and form.",
              "time": "2 weeks",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 3: Drawing Muscles in Different Poses",
              "description": "Practice drawing muscle groups in various dynamic poses.",
              "time": "1 week",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            }
          ]
        },
        {
          "name": "Task 3: Figure Drawing",
          "description": "Combine skeletal and muscular knowledge to draw the human figure.",
          "time": "4 weeks",
          "subtasks": [
            {
              "name": "Subtask 1: Proportions of the Human Figure",
              "description": "Practice drawing the human figure with correct proportions.",
              "time": "1 week",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 2: Figure Drawing from Reference",
              "description": "Practice drawing the human figure from photo references.",
              "time": "2 weeks",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 3: Figure Drawing from Life",
              "description": "Practice drawing the human figure from life, if possible.",
              "time": "1 week",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            }
          ]
        }
      ]
    },
    {
      "name": "Stage 3: Advanced Anatomy and Dynamic Poses",
      "timeframe": "4 months",
      "tasks": [
        {
          "name": "Task 1: Dynamic Poses and Foreshortening",
          "description": "Learn to draw the human figure in dynamic poses and foreshortening.",
          "time": "4 weeks",
          "subtasks": [
            {
              "name": "Subtask 1: Understanding Foreshortening",
              "description":
                  "Learn the principles of foreshortening and how to apply them to figure drawing.",
              "time": "1 week",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 2: Drawing Dynamic Poses from Reference",
              "description": "Practice drawing dynamic poses from photo references.",
              "time": "2 weeks",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 3: Drawing Dynamic Poses from Life",
              "description": "Practice drawing dynamic poses from life, if possible.",
              "time": "1 week",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            }
          ]
        },
        {
          "name": "Task 2: Hands and Feet",
          "description": "Focus on drawing the intricate details of hands and feet.",
          "time": "4 weeks",
          "subtasks": [
            {
              "name": "Subtask 1: Anatomy of Hands and Feet",
              "description": "Study the anatomy and structure of hands and feet.",
              "time": "1 week",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 2: Drawing Hands from Reference",
              "description":
                  "Practice drawing hands from various angles and poses using references.",
              "time": "2 weeks",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 3: Drawing Feet from Reference",
              "description":
                  "Practice drawing feet from various angles and poses using references.",
              "time": "1 week",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            }
          ]
        },
        {
          "name": "Task 3: Facial Anatomy and Expressions",
          "description": "Learn to draw the human face with accurate anatomy and expressions.",
          "time": "4 weeks",
          "subtasks": [
            {
              "name": "Subtask 1: Facial Proportions and Features",
              "description": "Study the proportions and features of the human face.",
              "time": "1 week",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 2: Drawing Facial Expressions",
              "description": "Practice drawing a range of facial expressions.",
              "time": "2 weeks",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            },
            {
              "name": "Subtask 3: Portraits from Reference",
              "description": "Practice drawing portraits from photo references.",
              "time": "1 week",
              "resources": [
                {"content": "", "links": []}
              ],
              "quizzes": []
            }
          ]
        }
      ]
    }
  ],
  "id": "680dd61080553ccbdfa39c9d",
  "userId": "facad6c5-da0d-4196-a565-e59633bcbf9e",
  "title": "Anatomy Drawing Roadmap for Beginners",
  "createdAt": "2025-04-27T07:00:32.053Z",
  "updatedAt": "2025-04-27T07:00:32.053Z"
};
