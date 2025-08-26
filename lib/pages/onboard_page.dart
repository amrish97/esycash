import 'package:flutter/material.dart';
import 'package:newcodepluse/pages/login_page.dart';
import 'package:newcodepluse/providers/onboard_provider.dart';
import 'package:newcodepluse/resources/app_colors.dart';
import 'package:newcodepluse/resources/app_dimention.dart';
import 'package:newcodepluse/resources/app_style.dart';
import 'package:newcodepluse/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnBoardProvider(),
      child: Consumer<OnBoardProvider>(
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: AppColors.screenBgColor,
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PageView(
                controller: value.controller,
                onPageChanged: (index) {
                  value.setLastPage(index == 2);
                },
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ...value.pageData.asMap().entries.map((toElement) {
                    return buildPage(
                      url: toElement.value['image'],
                      title: toElement.value['content'],
                      subtitle: toElement.value['subContent'],
                      index: toElement.key,
                      provider: value,
                      context: context,
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildPage({
    required String url,
    required String title,
    required String subtitle,
    required int index,
    required OnBoardProvider provider,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Center(
            child: Image.asset(
              url,
              fit: BoxFit.contain,
              width:
                  index == 1
                      ? MediaQuery.of(context).size.width - 30
                      : MediaQuery.of(context).size.width,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: '',
                  style: AppTextStyles.onBoardStyle,
                  children: <TextSpan>[
                    if (index == 0)
                      TextSpan(
                        text: 'Welcome !',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                      ),
                    TextSpan(text: title, style: AppTextStyles.onBoardStyle),
                    if (index == 1)
                      TextSpan(
                        text: 'Money!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                      ),
                    if (index == 2)
                      TextSpan(
                        text: 'Priority!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                      ),
                  ],
                ),
              ),
              PrimaryText(
                text: subtitle,
                size: AppDimen.textSize18,
                color: AppColors.primary,
                weight: FontWeight.w500,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: provider.controller,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.primary,
                      dotColor: AppColors.primaryDim,
                      dotHeight: 10,
                      dotWidth: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (index < 2) {
                        provider.controller.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                    },
                    child: Image.asset(
                      "assets/images/bottomIcon.png",
                      scale: 1.6,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
