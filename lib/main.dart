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


import 'package:zesta_1/view/screen/entry/splash_screen.dart';
import 'package:zesta_1/dependency_injection/instance_bind.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService.initializeNotifications();
  NotificationService.handleBackgroundMessages();
   Get.put(FirebaseControl(), permanent: true);
   Get.put(EventController(), permanent: true);
Get.put(ProfileController());
// Get.lazyPut<FilterController>(() => FilterController()); 

   Stripe.publishableKey = AppKeys.stripePublishableKey;
     Get.put(PaymentController());
      
  
  
  runApp(MyApp());
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
      home:const SplashScreen(),
    );
  }
}