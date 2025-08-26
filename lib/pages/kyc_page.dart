import 'package:flutter/material.dart';
import 'package:newcodepluse/pages/card_detail_page.dart';
import 'package:newcodepluse/providers/kyc_provider.dart';
import 'package:newcodepluse/resources/app_colors.dart';
import 'package:newcodepluse/resources/app_dimention.dart';
import 'package:newcodepluse/resources/app_style.dart';
import 'package:newcodepluse/widgets/custom_button.dart';
import 'package:newcodepluse/widgets/custom_text.dart';
import 'package:newcodepluse/widgets/custom_textField.dart';
import 'package:provider/provider.dart';

class KycPage extends StatefulWidget {
  const KycPage({super.key});

  @override
  State<KycPage> createState() => _KycPageState();
}

class _KycPageState extends State<KycPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.screenBgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.screenBgColor,
        forceMaterialTransparency: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText(
              text: "Upload KYC",
              color: AppColors.primary,
              size: 30,
              weight: FontWeight.w600,
            ),
            PrimaryText(
              text: "The following are information we want from you.",
              color: AppColors.greyTextColor,
              size: 16,
              weight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => KycProvider(),
        child: Consumer<KycProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(provider.tabs.length, (index) {
                    final isSelected = provider.selectedIndex == index;
                    final status = provider.formStatuses[index];
                    IconData? statusIcon;
                    Color? iconColor;
                    if (status == FormStatus.success) {
                      statusIcon = Icons.check_circle;
                      iconColor = AppColors.greenColor;
                    } else if (status == FormStatus.error) {
                      statusIcon = Icons.error;
                      iconColor = AppColors.redColor;
                    }
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => provider.changeTab(index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    isSelected
                                        ? AppColors.primary
                                        : AppColors.grey,
                                width: 7,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: IntrinsicHeight(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(statusIcon, color: iconColor, size: 30),
                                PrimaryText(
                                  text: provider.tabs[index],
                                  color:
                                      isSelected
                                          ? AppColors.primary
                                          : AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: IndexedStack(
                    index: provider.selectedIndex,
                    children: [
                      getFormWidget(
                        formKey: provider.personalFormKey,
                        provider: provider,
                      ),
                      getFormWidget(
                        formKey: provider.idFormKey,
                        provider: provider,
                      ),
                      getFormWidget(
                        formKey: provider.bankFormKey,
                        provider: provider,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getFormWidget({
    required GlobalKey<FormState> formKey,
    required KycProvider provider,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Form(
        key: formKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (formKey == provider.personalFormKey) ...[
                        PrimaryText(
                          text: "Enter your Details",
                          size: AppDimen.textSize22,
                          color: AppColors.black,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(height: 20),
                        CustomTextFormField(
                          label: "Enter Your Name",
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        CustomTextFormField(
                          label: "Mobile Number",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        CustomTextFormField(
                          label: "Email Address",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email Address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        CustomTextFormField(
                          label: "Pin Code",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your pin Code';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                      if (formKey == provider.idFormKey) ...[
                        PrimaryText(
                          text: "Upload Your Aadhaar Card",
                          size: 23,
                          color: AppColors.black,
                          weight: FontWeight.w600,
                        ),
                        PrimaryText(
                          text:
                              "Upload a clear front and back image of your Aadhaar card (JPG, PNG, or PDF, max 5MB). Your details are encrypted and safe",
                          size: 16,
                          color: AppColors.greyTextColor,
                          weight: FontWeight.w500,
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.greenColor,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo,
                                      color: AppColors.greenColor,
                                    ),
                                    SizedBox(height: 5),
                                    PrimaryText(
                                      text: "Select File to Upload",
                                      size: 16,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.greenColor,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      color: AppColors.greenColor,
                                    ),
                                    SizedBox(height: 5),
                                    PrimaryText(
                                      text: "Take a Photo",
                                      size: 16,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (formKey == provider.bankFormKey) ...[
                        PrimaryText(
                          text: "Enter your Bank Details",
                          size: 23,
                          color: AppColors.black,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(height: 20),
                        CustomTextFormField(
                          label: "Enter Account Number",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your account number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        CustomTextFormField(
                          label: "Enter IFSC Code",
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your IFSC code';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        CustomTextFormField(
                          label: "Enter Bank Name",
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your bank name';
                            }
                            return null;
                          },
                        ),
                      ],
                      Spacer(),
                      CustomButton(
                        text: "Next",
                        onTap: () {
                          if (provider.validateCurrentForm()) {
                            if (formKey == provider.personalFormKey) {
                              provider.changeTab(1);
                            } else if (formKey == provider.idFormKey) {
                              provider.changeTab(2);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CardDetailPage(),
                                ),
                              );
                            }
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
    );
  }
}
