import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_tracker_mobile/data/config/api_client.dart';
import 'package:study_tracker_mobile/data/config/api_service.dart';
import 'package:study_tracker_mobile/domain/repository/auth_repository.dart';
import 'package:study_tracker_mobile/presentation/resources/api_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/routes_manager.dart';

class AuthService implements AuthRepository {
  final _apiCLient = GetIt.instance.get<ApiClient>().dio;
  final _pref = GetIt.instance.get<SharedPreferences>();
  final _storage = GetIt.instance.get<FlutterSecureStorage>();

  @override
  Future<void> signIn(String username, String password) async {
    try {
      final response = await _apiCLient.post(
        ApiManager.login,
        data: {
          'username': username,
          'password': password,
        },
      );

      final result = response.data['result'];
      final token = result['token'];

      await _pref.setBool('isLogin', true);
      await _storage.write(key: 'token', value: token);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ('Invalid email or password');
      } else if (e.response?.statusCode == 500) {
        throw ('Server error');
      } else {
        throw ('Login failed: ${e.message}');
      }
    } catch (e) {
      throw ('Unexpected error: $e');
    }
  }

  @override
  Future<void> signOut() async {
    await _pref.setBool('isLogin', false);
    await _storage.delete(key: 'token');
    Get.offAllNamed(Routes.loginRoute);
  }

  @override
  Future<void> signUp(Object? data) async {
    try {
      final response = await _apiCLient.post(
        ApiManager.register,
        data: data,
      );

      if (response.statusCode == 200) {
        Get.offAllNamed(Routes.loginRoute);
      } else {
        throw ('Registration failed');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        if (e.response?.data['code'] == 1002) {
          throw ('Tên đăng nhập hoặc email đã tồn tại, vui lòng thử lại với tên khác');
        }
        throw ('Thông tin đăng ký không hợp lệ');
      } else {
        throw ('Hệ thống đang bảo trì, vui lòng thử lại sau');
      }
    } catch (e) {
      throw ('Unexpected error: $e');
    }
  }
}
