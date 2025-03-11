import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_tracker_mobile/data/config/api_client.dart';
import 'package:study_tracker_mobile/data/config/api_service.dart';

final _getIt = GetIt.instance;

Future<void> setupDI() async {
  _getIt.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );

  _getIt.registerLazySingleton(() => FlutterSecureStorage());
  _getIt.registerLazySingleton(() => ApiClient());
  _getIt.registerLazySingleton(() => ApiService());
}
