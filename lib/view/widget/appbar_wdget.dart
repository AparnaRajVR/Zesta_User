// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zesta_1/constant/color.dart';
// import 'package:zesta_1/services/event_controller.dart';
// import 'package:zesta_1/view/widget/event/search_dashboard.dart';
// import 'package:zesta_1/view/widget/location_dialogue.dart';

// class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
//   final LocationDialogController locationController;
// final EventController eventController = Get.find<EventController>();

//   AppBarWidget({super.key, required this.locationController});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: AppColors.primary,
//       elevation: 0,
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Let’s Get Started!",
//             style: TextStyle(
//               color: AppColors.textlight,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Obx(() => Text(
//                 locationController.locationText.value,
//                 style: const TextStyle(
//                   color: AppColors.textlight,
//                   fontSize: 14,
//                 ),
//               )),
//         ],
//       ),
//       actions: [
//         IconButton(
//   icon: const Icon(Icons.search, color: AppColors.textlight),
//   onPressed: () {
//     // final eventController = Get.find<EventController>();
//     // Get.to(() => EventSearchPage(events: eventController.events));
//   },
// ),

//         //    IconButton(
//         //   icon: const Icon(FontAwesomeIcons.heart, color: AppColors.textlight),
//         //   onPressed: () {},
//         // ),
//         // IconButton(
//         //   icon: const Icon(Icons.notifications, color: AppColors.textlight),
//         //   onPressed: () {},
//         // ),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/services/event_controller.dart';
import 'package:zesta_1/services/search_controller.dart'; // Import EventSearchController
import 'package:zesta_1/view/widget/event/search_dashboard.dart';
import 'package:zesta_1/view/widget/location_dialogue.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final LocationDialogController locationController;

  AppBarWidget({super.key, required this.locationController});

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
          onPressed: () {
            // Initialize EventSearchController before navigation
            Get.put(EventSearchController());
            Get.to(() => EventSearchPage());
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}