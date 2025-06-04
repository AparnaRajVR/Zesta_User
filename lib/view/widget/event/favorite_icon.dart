import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/services/event_controller.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/constant/color.dart';

class EventFavoriteIcon extends StatelessWidget {
  final EventModel event;

  const EventFavoriteIcon({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventController>();
    final isFavorited = controller.favoriteEvents.contains(event.id).obs;

    return Obx(() => Container(
          decoration: BoxDecoration(
            color: AppColors.textdark,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            icon: Icon(
              isFavorited.value ? Icons.favorite : Icons.favorite_border,
              color: isFavorited.value ? AppColors.accent : AppColors.textlight,
            ),
            onPressed: () {
              controller.toggleFavorite(event);
              isFavorited.value = !isFavorited.value;
            },
          ),
        ));
  }
}
