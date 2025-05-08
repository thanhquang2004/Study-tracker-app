import 'package:flutter_dotenv/flutter_dotenv.dart';

final urlIdentity = dotenv.env['IDENTITY_SERVICE'];
final urlSchedule = dotenv.env['SCHEDULE_SERVICE'];
final urlNote = dotenv.env['NOTE_SERVICE'];
final urlRoadmap = dotenv.env['ROADMAP_SERVICE'];

class ApiManager {
  static String login = '$urlIdentity/auth/token';
  static String register = '$urlIdentity/users/registration';
  static String refreshToken = '$urlIdentity/auth/refresh';
  static String changePassword = '$urlIdentity/users/my-info/password';
  static String logout = '/auth/logout';
  static String user = '/user';
  static String userUpdate = '/user/update';
  static String userPassword = '/user/password';
  static String userAvatar = '/user/avatar';
  static String userAvatarUpdate = '/user/avatar/update';
  static String userAvatarDelete = '/user/avatar/delete';
  static String userAvatarUpload = '/user/avatar/upload';
  static String userAvatarUploadBase64 = '/user/avatar/upload/base64';
  static String generateQuiz = '$urlRoadmap/generateQuestion';
  static String generateRoadmap = '$urlRoadmap/generateRoadmap';
  static String getMyNotes(String userId) => '$urlNote/get-note-by/$userId';
  static String createNote = '$urlNote/create-note';
  static String updateNote(String noteId) => '$urlNote/$noteId';
  static String deleteNote(String noteId) => '$urlNote/$noteId';
  static String getScheduleByDate = '$urlSchedule/my-schedules';
  static String createSchedule = '$urlSchedule/create-schedule';
  static String addAllSchedule = '$urlSchedule/add-all';   
  static String scheduleById(String id) => '$urlSchedule/$id';
}
