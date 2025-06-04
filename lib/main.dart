
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/keys.dart';
import 'package:zesta_1/services/event_controller.dart';
import 'package:zesta_1/services/firebase_control.dart';
import 'package:zesta_1/services/notification_services.dart';
import 'package:zesta_1/services/profile_controller.dart';
import 'package:zesta_1/services/stripe_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:zesta_1/view/screen/entry/splash_screen.dart';
import 'package:zesta_1/services/instance_bind.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Top-level background handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Optionally show a notification or handle data
  NotificationService.showNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Register background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Set up foreground notification handling
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    NotificationService.showNotification(message);
  });

  // Request notification permissions (important for Android 13+ and iOS)
  await FirebaseMessaging.instance.requestPermission();

  // Optionally print device token for testing
  // String? token = await FirebaseMessaging.instance.getToken();
  // print('FCM Token: $token');

  // Your existing dependency injection
  Get.put(FirebaseControl(), permanent: true);
  Get.put(EventController(), permanent: true);
  Get.put(ProfileController());
  Stripe.publishableKey = AppKeys.stripePublishableKey;
  Get.put(PaymentController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InstanceBind(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: ('inter'),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
