import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:study_tracker_mobile/data/config/api_service.dart';
import 'package:study_tracker_mobile/domain/repository/auth_repository.dart';
import 'package:study_tracker_mobile/presentation/resources/api_manager.dart';

class AuthService implements AuthRepository {
  final _apiService = GetIt.instance.get<ApiService>();
  final _storage = GetIt.instance.get<FlutterSecureStorage>();

  @override
  Future<void> signIn(String email, String password) async {
    try {
      // final response = await _apiService.post(
      //   ApiManager.login,
      //   data: {
      //     'email': email,
      //     'password': password,
      //   },
      // );
      // if (response.statusCode == 200) {
      //   await _storage.write(key: "isLogin", value: "true");
      //   await _storage.write(
      //       key: "access_token", value: response.data['access_token']);
      //   await _storage.write(
      //       key: "refresh_token", value: response.data['refresh_token']);
      //
      // } else {
      //   throw Exception(response.data['message'] ?? "Đăng nhập thất bại");
      // }
      await Future.delayed(const Duration(seconds: 2));
      _checkValidateLogin(email, password);
      if (email == 'test' && password == '123') {
        await _storage.write(key: "isLogin", value: "true");
      } else {
        throw Exception("Đăng nhập thất bại");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.error ?? "Đăng nhập thất bại");
      } else {
        throw Exception("Không thể kết nối đến máy chủ");
      }
    }
  }

  @override
  Future<void> signOut() {
    return _storage.delete(key: 'isLogin');
  }

  @override
  Future<void> signUp(String fullName, String email, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      _checkValidateRegister(fullName, email, password);
      if (email == 'test' && password == '123') {
      } else {
        throw "Đăng ký thất bại";
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw (e.error ?? "Đăng nhập thất bại");
      } else {
        throw ("Không thể kết nối đến máy chủ");
      }
    }
  }

  void _checkValidateLogin(String email, String password) {
    if (email.isEmpty) {
      throw ("Email không được để trống");
    }
    if (password.isEmpty) {
      throw ("Mật khẩu không được để trống");
    }
  }

  void _checkValidateRegister(
    String fullName,
    String email,
    String password,
  ) {
    if (fullName.isEmpty) {
      throw ("Họ tên không được để trống");
    }
    if (email.isEmpty) {
      throw ("Email không được để trống");
    }
    if (!email.contains('@')) {
      throw ("Email không hợp lệ");
    }
    if (password.isEmpty) {
      throw ("Mật khẩu không được để trống");
    }
    if (password.length < 8) {
      throw ("Mật khẩu phải lớn hơn 8 ký tự");
    }
  }
}
