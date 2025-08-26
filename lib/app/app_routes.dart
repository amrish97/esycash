import 'package:flutter/material.dart';
import 'package:newcodepluse/pages/kyc_page.dart';
import 'package:newcodepluse/pages/onboard_page.dart';
import 'package:newcodepluse/pages/splash_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    AppRouteEnum.splash.name: (context) => const SplashPage(),
    AppRouteEnum.onBoard.name: (context) => const OnboardPage(),
    AppRouteEnum.kycPage.name: (context) => const KycPage(),
  };
}

enum AppRouteEnum { splash, onBoard, verifyPhone, kycPage }
