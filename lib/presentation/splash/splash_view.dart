import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_tracker_mobile/data/services/auth_service.dart';
import 'package:study_tracker_mobile/presentation/resources/assets_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final storage = GetIt.instance.get<FlutterSecureStorage>();
  

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  Future<void> _startDelay() async {
    await GetIt.instance
        .isReady<SharedPreferences>(); // Chờ SharedPreferences sẵn sàng
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  Future<void> _goNext() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    final String? isLoginStr = await storage.read(key: "isLogin");
    final bool isLogin = isLoginStr == "true";
    final bool isFirstTime = pref.getBool("isFirstTime") ?? true;

    if (mounted) {
      if (isFirstTime) {
        pref.setBool("isFirstTime", false);
        Get.toNamed( Routes.onBoardingRoute);
      } else if (isLogin) {
        try{
          await AuthService().refreshToken();        } catch (e) {
        
        
        Get.toNamed( Routes.mainRoute);
        }
      } else {
        Get.toNamed( Routes.loginRoute);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XColors.primary,
      body: Center(
        child: SvgPicture.asset(
          ImageAssets.splashLogo,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
