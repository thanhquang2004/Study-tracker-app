import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:study_tracker_mobile/app/app.dart';
import 'package:study_tracker_mobile/app/di.dart';
import 'package:study_tracker_mobile/presentation/login/cubit/login_cubit.dart';
import 'package:study_tracker_mobile/presentation/onboarding/cubit/onboarding_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await setupDI();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => OnboardingCubit()),
    BlocProvider(create: (context) => LoginCubit()),
  ], child: MyApp()));
}
