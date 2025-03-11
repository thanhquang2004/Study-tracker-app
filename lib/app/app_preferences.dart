import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences =
      GetIt.instance<SharedPreferences>();
  final FlutterSecureStorage _secureStorage =
      GetIt.instance<FlutterSecureStorage>();

  Future<void> setUserToken(String token) async {
    _secureStorage
        .write(key: 'accessToken', value: token)
        .then((value) => print('Token saved'))
        .catchError((error) => print('Error saving token: $error'));
  }

  Future<String?> getUserToken() async {
    return _secureStorage.read(key: 'accessToken');
  }

  Future<void> setIsUserLoggedIn(bool value) async {
    _sharedPreferences.setBool('isLogin', value);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool('isLogin') ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove('isLogin');
    _secureStorage.delete(key: 'accessToken');
  }
}
