import 'package:flutter/material.dart';
import 'package:newcodepluse/pages/home_page.dart';
import 'package:newcodepluse/providers/kyc_provider.dart';
import 'package:newcodepluse/resources/app_colors.dart';
import 'package:newcodepluse/widgets/custom_button.dart';
import 'package:newcodepluse/widgets/custom_text.dart';
import 'package:newcodepluse/widgets/custom_textField.dart';
import 'package:newcodepluse/widgets/loadingState.dart';
import 'package:provider/provider.dart';

class CardDetailPage extends StatelessWidget {
  const CardDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => KycProvider(),
      child: Consumer<KycProvider>(
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
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Form(
                    key: value.cardFormKey,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PrimaryText(
                                    text: "Add Your Card Details",
                                    color: AppColors.primary,
                                    size: 30,
                                    weight: FontWeight.w600,
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: Image.asset(
                                            "assets/images/Card.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: IntrinsicHeight(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            child: Center(
                                              child: Container(
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.primary,
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: AppColors.white,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  CustomTextFormField(
                                    label: "Enter Card Number",
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your card number';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  CustomTextFormField(
                                    label: "Expiry Date",
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your expiry Date';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  CustomTextFormField(
                                    label: "Card Name",
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your Card Name';
                                      }
                                      return null;
                                    },
                                  ),
                                  Spacer(),
                                  CustomButton(
                                    text: "Continue",
                                    onTap: () {
                                      if (value.cardFormKey.currentState!
                                          .validate()) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => const HomePage(),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              loadingState(isLoading: value.getIsLoading),
            ],
          );
        },
      ),
    );
  }
}
