import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // <-- Add this import
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/services/event_controller.dart';

class PastEventsHorizontalList extends StatelessWidget {
  final EventController eventController = Get.find<EventController>();

  PastEventsHorizontalList({super.key, required List<EventModel> events});

  // Helper to format date as "March 25, 2025"
  String formatEventDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MMMM d, y').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final pastEvents = eventController.pastWeekEvents;
      if (pastEvents.isEmpty) {
        return const SizedBox(); 
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Past Week Events',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 200, // Increased to fit image
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pastEvents.length,
              itemBuilder: (context, index) {
                final event = pastEvents[index];
                // Use event.images?.first if available, else show a placeholder
                final imageUrl = (event.images != null && event.images!.isNotEmpty)
                    ? event.images!.first
                    : null;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    width: 210,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // IMAGE
                        SizedBox(
                          height: 80,
                          width: double.infinity,
                          child: imageUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.broken_image),
                                  ),
                                )
                              : Container(
                                  color: AppColors.textlight,
                                  child: const Center(
                                    child: Icon(Icons.image, size: 40, color: Colors.grey),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 8),
                        // NAME
                        Text(
                          event.name ?? 'No Name',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // CITY
                        Text(
                          event.city ?? '',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        // DATE
                        Text(
                          formatEventDate(event.eventDate), // Use the formatted date
                          style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
