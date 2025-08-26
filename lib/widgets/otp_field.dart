import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newcodepluse/pages/kyc_page.dart';
import 'package:newcodepluse/resources/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpField extends StatelessWidget {
  final FocusNode focusNode;
  const OtpField({super.key, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      appContext: context,
      focusNode: focusNode,
      blinkWhenObscuring: true,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        fieldHeight: 60,
        fieldWidth: 60,
        activeColor: AppColors.otpFieldColor,
        inactiveColor: AppColors.otpFieldColor,
        selectedColor: AppColors.otpFieldColor,
        errorBorderColor: AppColors.redColor,
      ),
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      animationDuration: const Duration(milliseconds: 300),
      onCompleted: (v) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const KycPage()),
        );
      },
    );
  }
}
