import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/view/widget/location_dialogue.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final LocationDialogController locationController;

  const AppBarWidget({super.key, required this.locationController});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
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
          onPressed: () {},
        ),
           IconButton(
          icon: const Icon(FontAwesomeIcons.heart, color: AppColors.textlight),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications, color: AppColors.textlight),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
