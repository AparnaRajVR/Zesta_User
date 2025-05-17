import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:zesta_1/view/screen/dash_board.dart';
import 'package:zesta_1/view/screen/entry/onboard.dart';
import 'package:zesta_1/view/widget/animated_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _navigate(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.off(() => Dashboard());
    } else {
      Get.off(() => OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () => _navigate(context));
    return Scaffold(
           body: Center(child: AnimatedSplashLogo()),

     
    );
  }
}