import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:study_tracker_mobile/presentation/dashboard/cubit/dashboard_cubit.dart';
import 'package:study_tracker_mobile/presentation/login/cubit/login_cubit.dart';
import 'package:study_tracker_mobile/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:study_tracker_mobile/presentation/setting/cubit/setting_cubit.dart';

final List<SingleChildWidget> blocProviderManager = [
  BlocProvider(create: (context) => OnboardingCubit()),
  BlocProvider(create: (context) => LoginCubit()),
  BlocProvider(create: (context) => DashboardCubit()),
  BlocProvider(create: (context) => SettingCubit()..loadSettings()),
];
