import 'package:flutter/material.dart';
import 'package:newcodepluse/resources/app_colors.dart';
import 'package:newcodepluse/widgets/custom_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBgColor,
      body: Center(child: PrimaryText(text: "HomePage")),
    );
  }
}
