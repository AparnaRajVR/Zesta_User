import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/services/event_controller.dart';
import 'package:zesta_1/view/widget/event/event_card.dart';
import 'package:zesta_1/view/widget/event/event_details.dart'; 
class AllEventsGridPage extends StatelessWidget {
  final List<EventModel> events;
  final eventController = Get.find<EventController>();

  AllEventsGridPage({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Events"),
      ),
      body: Obx(() {
        if (eventController.events.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: eventController.events.length,
          itemBuilder: (context, index) {
            final event = eventController.events[index];
            final categoryName =
                eventController.getCategoryName(event.categoryId ?? '');
            final formattedDate = event.date != null
                ? DateFormat('MMMM d yyyy').format(DateTime.parse(event.date!))
                : 'Coming Soon';

            return GestureDetector(
              onTap: () {
                Get.to(() => EventDetailsPage(event: event));
              },
              child: EventCard(
                imageUrl: event.images?.isNotEmpty ?? false
                    ? event.images!.first
                    : 'https://via.placeholder.com/200x150',
                date: formattedDate,
                eventName: event.name ?? 'Unnamed Event',
                location: event.city ?? 'Unknown Location',
                categoryName: categoryName,
              ),
            );
          },
        );
      }),
    );
  }
}
