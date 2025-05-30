
// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:zesta_1/constant/keys.dart';
// import 'package:zesta_1/model/payment_model.dart';

// class PaymentController extends GetxController {
//   Future<PaymentIntentModel?> makePayment(double amount) async {
//     try {
//       final dio = Dio();

//       // Stripe expects amount in cents
//       final int amountInCents = (amount * 100).toInt();

//       final response = await dio.post(
//         "https://api.stripe.com/v1/payment_intents",
//         data: {
//           "amount": amountInCents.toString(),
//           "currency": 'usd',
//         },
//         options: Options(
//           contentType: Headers.formUrlEncodedContentType,
//           headers: {
//             "Authorization": "Bearer ${AppKeys.stripeSecretKey}", 
//           },
//         ),
//       );

//       if (response.statusCode == 200 && response.data != null) {
//         final clientSecret = response.data['client_secret'];

//         await Stripe.instance.initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//             paymentIntentClientSecret: clientSecret,
//             merchantDisplayName: 'Zesta App',
//           ),
//         );

//         await Stripe.instance.presentPaymentSheet();

        

//         return PaymentIntentModel.fromJson(response.data);
//       }
//       throw Exception('Failed to create payment intent');
//     } catch (e) {
//       // You may want to show a dialog or snackbar here in production
//       rethrow;
//     }
//   }
// }

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:zesta_1/constant/keys.dart';
import 'package:zesta_1/model/payment_model.dart';

class PaymentController extends GetxController {
  Future<PaymentIntentModel?> makePayment(double amount) async {
    try {
      final dio = Dio();

      final int amountInCents = (amount * 100).toInt();

      final response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: {
          "amount": amountInCents.toString(),
          "currency": 'usd',
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer ${AppKeys.stripeSecretKey}",
          },
        ),
      );

      // Log the full response from Stripe
      print("Stripe PaymentIntent response: ${response.data}");

      if (response.statusCode == 200 && response.data != null) {
        final clientSecret = response.data['client_secret'];

        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: 'Zesta App',
          ),
        );

        try {
          await Stripe.instance.presentPaymentSheet();
        } on StripeException catch (e) {
          // Log Stripe-specific errors
          log("StripeException: ${e.error.localizedMessage}");
          Get.snackbar("Payment Error", e.error.localizedMessage ?? "Payment cancelled");
          return null;
        } catch (e) {
          // Log any other errors
          log("Other Exception: $e");
          Get.snackbar("Payment Error", "An error occurred during payment");
          return null;
        }

        return PaymentIntentModel.fromJson(response.data);
      }
      throw Exception('Failed to create payment intent');
    } catch (e) {
      // Log any errors in the try-catch
      log("PaymentController exception: $e");
      Get.snackbar("Payment Error", e.toString());
      rethrow;
    }
  }
}
