import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newcodepluse/controller/login_provider.dart';
import 'package:newcodepluse/resources/app_colors.dart';
import 'package:newcodepluse/resources/app_dimention.dart';
import 'package:newcodepluse/resources/app_font.dart';
import 'package:newcodepluse/resources/app_style.dart';
import 'package:newcodepluse/widgets/custom_button.dart';
import 'package:newcodepluse/widgets/custom_text.dart';
import 'package:newcodepluse/widgets/otp_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Consumer<LoginProvider>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Scaffold(
                backgroundColor: AppColors.screenBgColor,
                appBar: AppBar(
                  backgroundColor: AppColors.screenBgColor,
                  automaticallyImplyLeading: false,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryText(
                        text: "Verify Your Number",
                        color: AppColors.primary,
                        size: 30,
                        weight: FontWeight.w600,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: value.phoneNumberController,
                        keyboardType: TextInputType.phone,
                        style: AppTextStyles.body,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration(
                          hintText: "Mobile Number",
                          hintStyle: AppTextStyles.body,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Align(
                            widthFactor: 1,
                            alignment: Alignment.center,
                            child: Text(
                              "+91",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      buildCheckBox(
                        onTap: value.setRememberClick,
                        content: "Send me updates over Whatsapp",
                        isCheck: value.isRememberClick,
                        visibleCheck: true,
                      ),
                      Spacer(),
                      buildCheckBox(
                        onTap: value.setAcceptTerms,
                        content:
                            "which includes permission to securely share my data/documents with verified partners to process my application",
                        isCheck: value.isAcceptTerms,
                        visibleCheck: false,
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        text: "Get OTP",
                        onTap: () {
                          showBottomSheet(context: context, value: value);
                        },
                        isIconShow: true,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              loadingState(value.getIsLoading),
            ],
          );
        },
      ),
    );
  }

  void showBottomSheet({
    required BuildContext context,
    required LoginProvider value,
  }) async {
    if (value.phoneNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "You must enter a phone number",
            style: AppTextStyles.buttonTextStyle,
          ),
        ),
      );
      FocusScope.of(context).requestFocus(value.focusNodePhone);
    } else if (value.phoneNumberController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "You must enter a 10 digit number",
            style: AppTextStyles.buttonTextStyle,
          ),
        ),
      );
    } else if (!value.isAcceptTerms || !value.isRememberClick) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Kindly acknowledge the terms and conditions and reminder",
            style: AppTextStyles.buttonTextStyle,
          ),
        ),
      );
    } else {
      value.setIsLoading(true);
      await Future.delayed(const Duration(seconds: 2));
      value.setIsLoading(false);
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        showDragHandle: false,
        backgroundColor: AppColors.screenBgColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        builder: (context) {
          Future.delayed(const Duration(milliseconds: 300), () {
            if (!value.focusNodePhone.hasFocus) {
              FocusScope.of(context).requestFocus(value.focusNodePhone);
            }
          });
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const PrimaryText(
                      text: "Enter OTP",
                      size: 20,
                      weight: FontWeight.w600,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, color: AppColors.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                PrimaryText(
                  text: "6 Digit OTP has been sent to your mobile number",
                  size: 20,
                  color: AppColors.hintColor,
                  weight: FontWeight.w500,
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFDCDCDC),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: AppTextStyles.body,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    decoration: InputDecoration(
                      hintText: value.phoneNumberController.text ?? "",
                      hintStyle: AppTextStyles.body,
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      prefixIcon: Icon(Icons.phone, color: AppColors.primary),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                OtpField(focusNode: value.focusNodePhone),
                resendView(),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    }
  }

  Widget resendView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [PrimaryText(text: "Resend"), PrimaryText(text: " in 00 : 22")],
    );
  }

  Widget loadingState(bool isLoading) {
    if (!isLoading) return const SizedBox.shrink();

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5), // dimmed background
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // loader background
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
          ),
          padding: const EdgeInsets.all(24),
          width: 220,
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
                size: 16,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCheckBox({
    required GestureTapCallback onTap,
    required String content,
    required bool isCheck,
    required bool visibleCheck,
  }) {
    return Row(
      crossAxisAlignment:
          visibleCheck ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isCheck ? AppColors.primary : Colors.white,
                border: Border.all(color: AppColors.primary, width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              child:
                  isCheck
                      ? const Icon(
                        Icons.check,
                        color: AppColors.white,
                        size: AppDimen.textSize16,
                      )
                      : null,
            ),
          ),
        ),
        SizedBox(width: 6),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '',
              children: <TextSpan>[
                if (!visibleCheck) ...[
                  TextSpan(text: 'I agree to the ', style: AppTextStyles.body),
                  TextSpan(
                    text: 'Terms of Service & Privacy policy, ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontSize: AppDimen.textSize14,
                      fontFamily: AppFont.font,
                    ),
                  ),
                ],
                TextSpan(text: content, style: AppTextStyles.body),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
