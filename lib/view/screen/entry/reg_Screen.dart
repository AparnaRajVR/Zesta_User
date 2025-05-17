
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/view/screen/dash_board.dart';
import 'package:zesta_1/view/widget/registration_form.dart';

import '../../../constant/color.dart';
import '../../../services/firebase_control.dart';




class RegScreen extends GetWidget<FirebaseControl> {
  const RegScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    AppColors.second,
                   
                
                  ],
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Create Your\nAccount',
                  style: TextStyle(
                    fontSize: 30,
                    color: AppColors.textlight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
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
                child: RegistrationForm(
                  onRegister: (name, email, password, confirmPassword) {
                    controller.createUser(
                      name,
                      email,
                      password,
                      confirmPassword,
                    );
                  },
                  onLoginTap: () {
                 Get.to( () =>  Dashboard());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
