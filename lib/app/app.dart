import 'package:flutter/material.dart';
import 'package:newcodepluse/app/app_routes.dart';
import 'package:newcodepluse/resources/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      initialRoute: AppRouteEnum.splash.name,
      routes: AppRoutes.routes,
    );
  }
}
