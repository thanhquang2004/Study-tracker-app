import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:study_tracker_mobile/data/config/api_client.dart';
import 'package:study_tracker_mobile/data/services/auth_service.dart';
import 'package:study_tracker_mobile/presentation/resources/routes_manager.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio = GetIt.I.get<ApiClient>().dio;
  final AuthService authService = GetIt.I.get<AuthService>();
  final FlutterSecureStorage secureStorage = GetIt.I.get<FlutterSecureStorage>();

  TokenInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await secureStorage.read(key: 'token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        // Gọi refreshToken từ AuthService
        await authService.refreshToken();
        
        // Lấy token mới sau khi refresh
        final newToken = await secureStorage.read(key: 'token');
        if (newToken != null) {
          final clonedRequest = err.requestOptions;
          clonedRequest.headers['Authorization'] = 'Bearer $newToken';
          final response = await dio.fetch(clonedRequest);
          return handler.resolve(response);
        }
      } catch (e) {
        // Nếu refreshToken thất bại, logout
        await authService.signOut();
        print('[Auth] Refresh token failed → Redirecting to Login');
        Get.offAllNamed(Routes.loginRoute);
        return; // Kết thúc luôn
      }
    }

    // Nếu lỗi khác thì trả lỗi về
    super.onError(err, handler);
  }
}
