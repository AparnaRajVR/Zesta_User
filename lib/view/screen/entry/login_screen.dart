import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/view/widget/custom_feild.dart';
import 'package:zesta_1/view/widget/forgot_password.dart';

import '../../../services/firebase_control.dart';
import 'reg_screen.dart';


class LoginScreen extends GetWidget<FirebaseControl> {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController gmailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    void loginUser() {
      if (formKey.currentState?.validate() ?? false) {
        controller.login(
          gmailController.text,
          passwordController.text,
        );
      }
    }

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
                  AppColors.primary,
                  // AppColors.second,
                  // AppColors.accent,
                //    Color(0xffB81736),
                   AppColors.second,
              
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Hello\nSign in!',
                // text
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.textlight,
                  fontWeight: FontWeight.bold,
                ),
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
                      const SizedBox(height: 30),
                      CustomTextField(
                        label: 'Gmail',
                        hintText: 'Enter your Gmail',
                        controller: gmailController,
                        keyboardType: TextInputType.emailAddress,
                        icon: Icons.email,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: 'Password',
                        hintText: 'Enter your password',
                        controller: passwordController,
                        obscureText: true,
                        icon: Icons.lock,
                      ),
                      const SizedBox(height: 20),
                       Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: (){
                            Get.to(ForgotPassword());},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: AppColors.textdark,
                            ),
                          ),
                        )
                      ),
                      const SizedBox(height: 70),
                      GestureDetector(
                        onTap: loginUser,
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [
                                AppColors.primary,
                                AppColors.second,
                                
                              
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: AppColors.textlight,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
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

