
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/view/screen/entry/login_screen.dart';
import 'package:zesta_1/view/widget/otp_send.dart';
import 'package:zesta_1/view/screen/entry/reg_screen.dart';
import '../../../services/firebase_control.dart';

class WelcomeScreen extends GetWidget<FirebaseControl> {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity, 
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary,
              const Color(0XFF281537),
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Image.asset(
                'assets/images/logo.png',
                height: 170,
                width: 170,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 33,
                color: AppColors.textlight, 
              ),
            ),
            const SizedBox(height: 38),
            GestureDetector(
              onTap: () {
                Get.to( () => const LoginScreen());
                
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.textlight), 
                ),
                child: const Center(
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textlight,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
              Get.to( () => const RegScreen());
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  color: AppColors.textlight,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.textlight), 
                ),
                child: const Center(
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textdark, 
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Or Login with ' ,
              style: TextStyle(
                fontSize: 17,
                color: AppColors.textlight, 
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () 
                  {
                 controller.googleSignIN();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.textlight, 
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/google.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 28),
                GestureDetector(
                  onTap: () {
                    Get.to( () =>  OtpSend());
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.textlight, 
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.phone,
                        size: 29,
                        color: Colors.green, 
                      ),
                    ),
                  ),
                ),
                // const SizedBox(width: 28),
                // GestureDetector(
                //   onTap: () {
                //   //  controller.signInWithFacebook(); 
                //   },
                //   child: Container(
                //     height: 50,
                //     width: 50,
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: AppColors.textlight, 
                //     ),
                //     child: const Center(
                //       child: Icon(
                //         Icons.facebook_rounded,
                //         size: 32,
                //         color: Colors.blue, 
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
