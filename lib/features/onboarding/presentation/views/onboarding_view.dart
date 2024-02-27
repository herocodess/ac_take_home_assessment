import 'dart:async';

import 'package:acumen_technical_assessment/core/services/navigation_service.dart';
import 'package:acumen_technical_assessment/core/utils/colors.dart';
import 'package:acumen_technical_assessment/core/utils/extensions.dart';
import 'package:acumen_technical_assessment/core/utils/images.dart';
import 'package:acumen_technical_assessment/features/auth/presentation/views/login_view.dart';
import 'package:acumen_technical_assessment/widgets/buttons.dart';
import 'package:acumen_technical_assessment/widgets/measure_size.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController controller = PageController();
  PageController controller2 = PageController();

  int currentPage = 0;
  int max = 2;
  double width = 0;

  late final Timer timer;

  @override
  void initState() {
    super.initState();
    callTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  int loaderPercentage = 0;

  void callTimer() {
    timer = Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) async {
        loaderPercentage += 2;
        setState(() {});
        if (loaderPercentage == 10) {
          await Future.delayed(const Duration(milliseconds: 1200));
          if (currentPage == max) {
            controller.jumpToPage(0);
            controller2.jumpToPage(0);
          } else {
            controller.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
            controller2.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          }
          loaderPercentage = 0;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> onboardingData = <Map<String, String>>[
      {
        'img': AppImages.acOnboarding1,
        'text': context.l10n.ac_onboarding1_text
      },
      {
        'img': AppImages.acOnboarding2,
        'text': context.l10n.ac_onboarding2_text
      },
      {
        'img': AppImages.acOnboarding3,
        'text': context.l10n.ac_onboarding3_text
      },
    ];
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (value) {
              currentPage = value;
              setState(() {});
            },
            children: [
              for (final data in onboardingData)
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(data['img']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.blackColor.withOpacity(0.5),
                  AppColors.blackColor,
                ],
                stops: const [0.5, 1],
              ),
            ),
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        for (int i = 0; i < max + 1; i++)
                          Expanded(
                            child: MeasureSize(
                              onChange: (size) {
                                width = size.width;
                                setState(() {});
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white.withOpacity(.5),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                  ),
                                  AnimatedContainer(
                                    width: currentPage == i
                                        ? (loaderPercentage * 10)
                                            .percentOf(width)
                                        : 0,
                                    duration: Duration(
                                      milliseconds: currentPage == i ? 1200 : 0,
                                    ),
                                    height: 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    if (currentPage > 0) {
                      loaderPercentage = 0;
                      controller.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                      controller2.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: Container(color: AppColors.transparentColor),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    if (currentPage < max) {
                      loaderPercentage = 0;
                      controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                      controller2.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: Container(color: AppColors.transparentColor),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              color: AppColors.transparentColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: PageView(
                      controller: controller2,
                      children: [
                        for (final x in onboardingData)
                          Text(
                            x['text']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  PrimaryButton(
                      onTap: () {
                        pushToAndClearStack(context, const LoginView());
                      },
                      text: context.l10n.login),
                  const SizedBox(height: 15),
                  OutlinedPrimaryButton(
                      onTap: () {
                        pushToAndClearStack(context, const LoginView());
                      },
                      text: context.l10n.get_started),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 100,
            child: Center(
              child: Image.asset(
                AppImages.acLogo,
                scale: 2.1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
