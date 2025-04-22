import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_tracker_mobile/app/constant.dart';
import 'package:study_tracker_mobile/presentation/resources/routes_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/theme_manager.dart';

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp._internal(); // private named constructor
  int appState = 0; // app state variable
  static final MyApp instance =
      MyApp._internal(); // single instance -- singleton
  factory MyApp() => instance; // factory for class instance

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Constants.initialize(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      theme: getApplicationTheme(),
      initialRoute: Routes.splashRoute,
    );
  }
}
