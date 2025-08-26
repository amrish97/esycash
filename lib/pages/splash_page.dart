import 'package:flutter/material.dart';
import 'package:newcodepluse/app/app_routes.dart';
import 'package:newcodepluse/resources/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBgColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 1.0, end: 2.0),
            duration: Duration(seconds: 3),
            curve: Curves.easeInOut,
            builder: (context, scale, child) {
              return Transform.scale(scale: scale, child: child);
            },
            onEnd: () {
              Navigator.pushNamed(context, AppRouteEnum.onBoard.name);
            },
            child: Image.asset('assets/images/logo.png', width: 200),
          ),
        ),
      ),
    );
  }
}
