import 'package:flutter/material.dart';
import 'package:newcodepluse/resources/app_colors.dart';
import 'package:newcodepluse/resources/app_dimention.dart';
import 'package:newcodepluse/resources/app_font.dart';

class AppTextStyles {
  static TextStyle onBoardStyle = TextStyle(
    color: AppColors.primary,
    fontSize: 32,
    fontFamily: AppFont.font,
    fontWeight: AppFont.semiBold,
  );

  static TextStyle body = TextStyle(
    color: AppColors.primary,
    fontSize: AppDimen.textSize16,
    fontFamily: AppFont.font,
    fontWeight: AppFont.regular,
  );

  static TextStyle buttonTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: AppDimen.textSize16,
    fontFamily: AppFont.font,
    fontWeight: AppFont.regular,
  );
}
