import 'package:flutter/material.dart';
import 'package:study_tracker_mobile/presentation/dashboard/view/dashboard_view.dart';
import 'package:study_tracker_mobile/presentation/login/view/login_view.dart';
import 'package:study_tracker_mobile/presentation/onboarding/view/onboarding_view.dart';
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
      // case Routes.registerRoute:
      //   return MaterialPageRoute(builder: (_) => RegisterView());
      // case Routes.forgotPasswordRoute:
      //   return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => Dashboard());
      // case Routes.storeDetailsRoute:
      //   return MaterialPageRoute(builder: (_) => StoreDetailsView());
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
