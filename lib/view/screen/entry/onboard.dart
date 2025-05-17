

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/view/screen/entry/welcome.dart';
import '../../../constant/color.dart';
import '../../widget/dot_indicator.dart';
import '../../widget/onboard_widget.dart';

// ignore: must_be_immutable
class OnboardingScreen extends StatelessWidget {
 
  var currentPage = 0.obs;

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return Scaffold(
      backgroundColor: AppColors.textlight,
      body: Column(
        children: [
          
          Obx(() {
            return currentPage.value < 2
                ? Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          Get.off(() => WelcomeScreen());
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(); 
          }),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                currentPage.value = index; 
              },
              children: [
                OnboardingPage(
                  image: 'assets/images/onboard_1.png',
                  title: 'Discover Events That Matter',
                  subtitle: 'Explore a wide range of events curated just for you. Find, register, and participate with ease.',
                ),
                OnboardingPage(
                  image: 'assets/images/onboard_2.png',
                  title: 'Seamless Participation, Every Time',
                  subtitle: 'Get real-time updates, schedules, and notifications to stay on top of every event detail.',
                ),
                OnboardingPage(
                  image: 'assets/images/onboard_3.png',
                  title: 'Your Journey, Simplified',
                  subtitle: 'Track your registrations, connect with other participants, and make every event memorable.',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    3,
                    (index) => DotIndicator(isActive: currentPage.value == index),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (currentPage.value == 2) {
                      Get.off(() => WelcomeScreen());
                    } else {
                     
                      pageController.nextPage(
                          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    currentPage.value == 2 ? 'Get Started' : 'Next',
                    style: TextStyle(color: AppColors.textlight),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

