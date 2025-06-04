import 'package:flutter/material.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/view/widget/event/details_event.dart';
import 'package:zesta_1/services/event_controller.dart';
import 'package:get/get.dart';

class EventCategoryAgeLimitRow extends StatelessWidget {
  final EventModel event;

  const EventCategoryAgeLimitRow({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventController>();

    return Row(
      children: [
        Expanded(
          child: eventDetailItem(
            icon: Icons.category_outlined,
            title: 'Category',
            content: controller.getCategoryName(event.categoryId ?? ''),
          ),
        ),
        if ((event.ageLimit?.isNotEmpty ?? false)) ...[
          const SizedBox(width: 16),
          Expanded(
            child: eventDetailItem(
              icon: Icons.cake_outlined,
              title: 'Age Limit',
              content: event.ageLimit!.join(', '),
            ),
          ),
        ],
      ],
    );
  }
}
