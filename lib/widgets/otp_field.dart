import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpField extends StatefulWidget {
  final FocusNode focusNode;
  const OtpField({super.key, required this.focusNode});

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      appContext: context,
      focusNode: widget.focusNode,
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
        activeColor: const Color(0XFF979797).withAlpha(60),
        inactiveColor: const Color(0XFF979797).withAlpha(60),
        selectedColor: const Color(0XFF979797).withAlpha(60),
        errorBorderColor: Colors.red,
      ),
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      animationDuration: const Duration(milliseconds: 300),
      onCompleted: (v) {
        Navigator.pop(context);
      },
    );
  }
}
