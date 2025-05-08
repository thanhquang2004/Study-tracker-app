import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/presentation/generate/view/generate_view.dart';
import 'package:study_tracker_mobile/presentation/home/view/home_view.dart';
import 'package:study_tracker_mobile/presentation/login/view/login_view.dart';
import 'package:study_tracker_mobile/presentation/login/view/notifications_view';
import 'package:study_tracker_mobile/presentation/login/view/profile_view';
import 'package:study_tracker_mobile/presentation/login/view/settings_view.dart';
import 'package:study_tracker_mobile/presentation/onboarding/view/onboarding_view.dart';
import 'package:study_tracker_mobile/presentation/register/view/register_view.dart';
import 'package:study_tracker_mobile/presentation/resources/strings_manager.dart';
import 'package:study_tracker_mobile/presentation/splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String generate = "/generate";
  static const String profile = "/profile";
  static const String notifications = "/notifications";
  static const String settings = "/settings";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnboardingView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.generate:
        return MaterialPageRoute(builder: (_) => GenerateView());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case Routes.notifications:
        return MaterialPageRoute(builder: (_) => NotificationsView());
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => SettingsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.noRouteFound),
        ),
        body: Center(
          child: Text(
            AppStrings.noRouteFound,
          ),
        ),
      ),
    );
  }
}
