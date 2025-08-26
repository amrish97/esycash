import 'package:flutter/material.dart';
import 'package:newcodepluse/resources/app_colors.dart';
import 'package:newcodepluse/resources/app_dimention.dart';
import 'package:newcodepluse/widgets/custom_text.dart';

class loadingState extends StatelessWidget {
  final bool isLoading;
  const loadingState({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return const SizedBox.shrink();
    return Scaffold(
      backgroundColor: AppColors.black.withAlpha(20),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
          ),
          padding: const EdgeInsets.all(30),
          width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                backgroundColor: AppColors.grey,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),
              PrimaryText(
                text: "Please wait",
                size: AppDimen.textSize16,
                color: AppColors.primary,
                weight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
