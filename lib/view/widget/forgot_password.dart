import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/view/screen/entry/reg_screen.dart';
import 'package:zesta_1/view/widget/custom_feild.dart';

import '../../../services/firebase_control.dart';


class ForgotPassword extends GetWidget<FirebaseControl> {
  const ForgotPassword({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController gmailController = TextEditingController();
    // final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  // AppColors.primary,
                  // AppColors.second,
                  // AppColors.accent,
                   Color(0xffB81736),
                  
                 Color(0XFF281537),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 260.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: AppColors.textlight,
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 90),
                      CustomTextField(
                        label: 'Gmail',
                        hintText: 'Enter your Gmail',
                        controller: gmailController,
                        keyboardType: TextInputType.emailAddress,
                        
                      ),
                     //const SizedBox(height: 15),
                     
                       const SizedBox(height: 70),
                      GestureDetector(
                        onTap:(){controller.sendPasswordResetEmail(gmailController.text);},
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [
                                 // AppColors.primary,
                                // AppColors.second,
                                // AppColors.accent,
                                Color(0xffB81736),
                 
                               Color(0XFF281537),
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Reset Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: AppColors.textlight,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textaddn,
                              ),
                            ),
                            SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                               Get.to( () => const RegScreen());
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                  color: AppColors.textdark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
