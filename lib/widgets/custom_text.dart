import 'package:flutter/material.dart';
import 'package:newcodepluse/resources/app_colors.dart';
import 'package:newcodepluse/resources/app_dimention.dart';
import 'package:newcodepluse/resources/app_font.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color color;
  const PrimaryText({
    super.key,
    required this.text,
    this.size = AppDimen.textSize16,
    this.weight = AppFont.regular,
    this.color = AppColors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontFamily: AppFont.font,
        color: color,
        fontWeight: weight,
        height: 1.5,
      ),
    );
  }
}
