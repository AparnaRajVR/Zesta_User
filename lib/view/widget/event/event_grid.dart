

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/services/event_controller.dart';
import 'package:zesta_1/view/widget/event/event_card.dart';
import 'package:zesta_1/view/screen/event_details.dart'; 

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
      body: events.isEmpty
          ? const Center(child: Text("No events found"))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index]; // <-- Use the passed-in events
                final categoryName =
                    eventController.getCategoryName(event.categoryId ?? '');
                DateTime? eventDate;
                if (event.date is DateTime) {
                  eventDate = event.date as DateTime;
                } else if (event.date is String) {
                  eventDate = DateTime.tryParse(event.date as String);
                }
                final formattedDate = eventDate != null
                    ? DateFormat('MMMM d yyyy').format(eventDate)
                    : 'Coming Soon';

                return GestureDetector(
                  onTap: () {
                    Get.to(() => EventDetailsPage(event: event,));
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
            ),
    );
  }
}
