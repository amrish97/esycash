import 'package:flutter/material.dart';
import 'package:newcodepluse/pages/home_page.dart';
import 'package:newcodepluse/pages/onboard_page.dart';
import 'package:newcodepluse/pages/splash_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    AppRouteEnum.splash.name: (context) => const SplashPage(),
    AppRouteEnum.onBoard.name: (context) => const OnboardPage(),
    AppRouteEnum.home.name: (context) => const HomePage(),
  };
}

enum AppRouteEnum { splash, onBoard, home }
