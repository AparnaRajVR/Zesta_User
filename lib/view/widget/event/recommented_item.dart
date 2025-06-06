
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/services/event_controller.dart';
import 'package:zesta_1/view/widget/event/event_card.dart';
import 'package:zesta_1/view/screen/event_details.dart';
import 'package:zesta_1/view/widget/event/event_grid.dart';

class RecommendedItemsWidget extends StatelessWidget {
  final eventController = Get.find<EventController>();

  RecommendedItemsWidget({super.key, required List<EventModel> events});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            const Text(
              "Upcoming Events",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => AllEventsGridPage(
                  events: eventController.upcomingEventsByUserInterest,
                ));
              },
              child: Text(
                "See All >",
                style: TextStyle(fontSize: 14, color: AppColors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Obx(() {
          // Get filtered events
          final filteredEvents = eventController.upcomingEventsByUserInterest;

          if (eventController.categoryMap.isEmpty || 
              eventController.events.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (filteredEvents.isEmpty) {
            return Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/no_image.png',
                      width: 200,
                    ),
                    const SizedBox(height: 12),
                    const Text("No upcoming events in your interests"),
                  ],
                ),
              ),
            );
          }

          return SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                final categoryName = 
                    eventController.getCategoryName(event.categoryId ?? '');

                // Safe date parsing
                DateTime? eventDate;
                if (event.date is DateTime) {
                  eventDate = event.date as DateTime;
                } else if (event.date is String) {
                  eventDate = DateTime.tryParse(event.date as String);
                }
                final formattedDate = eventDate != null 
                    ? DateFormat('MMMM d yyyy').format(eventDate)
                    : 'Coming Soon';

                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => EventDetailsPage(event: event, ));
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
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
