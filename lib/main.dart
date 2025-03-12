import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:study_tracker_mobile/app/app.dart';
import 'package:study_tracker_mobile/app/di.dart';
import 'package:study_tracker_mobile/presentation/resources/bloc_provider_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await setupDI();

  runApp(MyApp());
}
