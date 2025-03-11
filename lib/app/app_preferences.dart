import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  final FlutterSecureStorage _secureStorage;

  AppPreferences(this._sharedPreferences, this._secureStorage);


  Future<void> setUserToken(String token) async {
    _secureStorage
        .write(key: 'accessToken', value: token)
        .then((value) => print('Token saved'))
        .catchError((error) => print('Error saving token: $error'));
  }

  Future<String?> getUserToken() async {
    return _secureStorage.read(key: 'accessToken');
  }

  Future<void> setUserRole(String role) async {
    _secureStorage
        .write(key: 'role', value: role)
        .then((value) => print('User ID saved'))
        .catchError((error) => print('Error saving user ID: $error'));
  }
  Future<String?> getUserRole() async {
    return _secureStorage.read(key: 'role');
  }

  Future<void> setIsUserLoggedIn() async {
    _sharedPreferences.setBool('isLogin', true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool('isLogin') ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove('isLogin');
    _secureStorage.deleteAll();
  }
}
