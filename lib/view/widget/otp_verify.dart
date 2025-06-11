// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zesta_1/constant/color.dart';
// import 'package:zesta_1/services/firebase_control.dart';
// import 'package:zesta_1/view/screen/dash_board.dart';


// class OtpScreen extends GetWidget<FirebaseControl>
//  {
//   final TextEditingController otpController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Enter OTP',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "We've sent an OTP on your phone number",
//               style: TextStyle(fontSize: 16, color: AppColors.textaddn),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: otpController,
//               decoration: InputDecoration(
//                 labelText: 'Enter 6 digit OTP',
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 String otp = otpController.text.trim();

//                 // if (otp.isEmpty || otp.length != 6) {
//                 //   Get.snackbar('Error', 'Please enter a valid 6-digit OTP.');
//                 //   return;
//                 // }

//                 controller.verifyOTP(otp).then((isVerified) {
//                   if (isVerified) {
                   
//                     Get.offAll(() => Dashboard());
//                   } else {
                    
//                     Get.snackbar('Error', 'Invalid OTP. Please try again.');
//                   }
//                 }).catchError((e) {
                 
//                   Get.snackbar('Error', 'Something went wrong. Please try again.');
//                 });
//               },
//               child: Text('VERIFY OTP'),
//             ),
//          ]) )
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/services/firebase_control.dart';
import 'package:zesta_1/view/screen/dash_board.dart';

class OtpScreen extends GetWidget<FirebaseControl> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Define your AppColors.primary color (you can adjust the shade as needed)
    

    return Scaffold(
      backgroundColor: AppColors.textlight,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter OTP',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 25),
            Text(
              "We've sent an OTP on your phone number",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                labelText: 'Enter 6 digit OTP',
                labelStyle: TextStyle(color: AppColors.primary),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                fillColor: AppColors.textlight,
                filled: true,
              ),
              keyboardType: TextInputType.number,
              cursorColor: AppColors.primary,
              style: TextStyle(color: AppColors.primary),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textlight,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  String otp = otpController.text.trim();

                  controller.verifyOTP(otp).then((isVerified) {
                    if (isVerified) {
                      Get.offAll(() => Dashboard());
                    } else {
                      Get.snackbar('Error', 'Invalid OTP. Please try again.');
                    }
                  }).catchError((e) {
                    Get.snackbar('Error', 'Something went wrong. Please try again.');
                  });
                },
                child: Text(
                  'VERIFY OTP',
                  style: TextStyle(
                    color:AppColors.textlight,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
