

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/services/search_controller.dart';
import 'package:zesta_1/view/screen/chat_bot.dart'; 
import 'package:zesta_1/view/widget/event/search_dashboard.dart';
import 'package:zesta_1/view/widget/location_dialogue.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final LocationDialogController locationController;

  const AppBarWidget({super.key, required this.locationController});

  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: AppColors.primary,
  elevation: 0,
  leading: Padding(
    padding: const EdgeInsets.only(left: 5.0),
    child: Image.asset(
      'assets/images/logo.png', 
      height: 100,
      width: 100,
    ),
  ),
  title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Let’s Get Started!",
            style: TextStyle(
              color: AppColors.textlight,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Obx(() => Text(
                locationController.locationText.value,
                style: const TextStyle(
                  color: AppColors.textlight,
                  fontSize: 14,
                ),
              )),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: AppColors.textlight),
          onPressed: () {
            // Initialize EventSearchController before navigation
            Get.put(EventSearchController());
            Get.to(() => EventSearchPage());
          },
        ),
       Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onTap: () {
          Get.to(BotpressChatbotPage());
        },
        child: Image.asset(
          'assets/images/chatbot.gif',
          height: 38,
          width: 38,
        ),
      ),
    ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
