import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:study_tracker_mobile/app/app_preferences.dart';
import 'package:study_tracker_mobile/data/config/api_client.dart';


class ApiService {
  final ApiClient _apiClient = GetIt.instance<ApiClient>();
  final AppPreferences _appPreferences = GetIt.instance<AppPreferences>();

  // Hàm lấy header chứa token
  Future<Map<String, String>> _getHeaders() async {
    final token = await _appPreferences.getUserToken();
    return {
      'Authorization': 'Bearer $token',
    };
  }

  // GET Method
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      final headers = await _getHeaders();
      final response = await _apiClient.dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // POST Method
  Future<Response> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      final headers = await _getHeaders();
      final response = await _apiClient.dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT Method
  Future<Response> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      final headers = await _getHeaders();
      final response = await _apiClient.dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE Method
  Future<Response> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      final headers = await _getHeaders();
      final response = await _apiClient.dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PATCH Method
  Future<Response> patch(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      final headers = await _getHeaders();
      final response = await _apiClient.dio.patch(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Upload File
  Future<Response> uploadFile(
    String endpoint, {
    required String filePath,
    required String fileName,
    String fileKey = 'file',
    Map<String, dynamic>? extraData,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
  }) async {
    try {
      final headers = await _getHeaders();
      FormData formData = FormData.fromMap({
        fileKey: await MultipartFile.fromFile(filePath, filename: fileName),
        if (extraData != null) ...extraData,
      });

      final response = await _apiClient.dio.post(
        endpoint,
        data: formData,
        options: Options(headers: headers),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Download File
  Future<Response> downloadFile(
    String endpoint,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final headers = await _getHeaders();
      final response = await _apiClient.dio.download(
        endpoint,
        savePath,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
