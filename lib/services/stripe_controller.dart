import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:zesta_1/constant/keys.dart';
import 'package:zesta_1/model/payment_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PaymentController extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<PaymentIntentModel?> makePayment(double amount) async {
    try {
      final dio = Dio();

      // Stripe expects amount in cents
      final int amountInCents = (amount * 100).toInt();

      final response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: {
          "amount": amountInCents.toString(),
          "currency": 'inr',
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer ${AppKeys.stripeSecretKey}",
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final clientSecret = response.data['client_secret'];

        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: 'Zesta App',
          ),
        );

        await Stripe.instance.presentPaymentSheet();

        // Show success notification
        await _showPaymentSuccessNotification(amount);

        return PaymentIntentModel.fromJson(response.data);
      }
      throw Exception('Failed to create payment intent');
    } catch (e) {
      // Show error notification
      await _showPaymentErrorNotification();
      rethrow;
    }
  }

  Future<void> _showPaymentSuccessNotification(double amount) async {
    const androidDetails = AndroidNotificationDetails(
      'payment_channel',
      'Payment Notifications',
      channelDescription: 'Notifications for payment transactions',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Ticket Confirmed!',
      'Your ticket has been booked successfully. Payment of ₹${amount.toStringAsFixed(2)} received. Enjoy the event!',
      notificationDetails,
    );
  }

  Future<void> _showPaymentErrorNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'payment_channel',
      'Payment Notifications',
      channelDescription: 'Notifications for payment transactions',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      1,
      'Payment Failed',
      'Could not complete the payment. Please try again.',
      notificationDetails,
    );
  }
}
