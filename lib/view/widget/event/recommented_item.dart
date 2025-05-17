import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/services/event_controller.dart';
import 'package:zesta_1/view/widget/event/event_card.dart';
import 'package:zesta_1/view/widget/event/event_details.dart';
import 'package:zesta_1/view/widget/event/event_grid.dart';

class RecommendedItemsWidget extends StatelessWidget {
  final List<EventModel> events;
  final eventController = Get.find<EventController>();

  RecommendedItemsWidget({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            Text(
              "Upcoming Events",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Get.to( AllEventsGridPage(events: events));
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
          if (eventController.categoryMap.isEmpty ||
              eventController.events.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return SizedBox(
            height: 250, 
           
            
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: eventController.events.length,
              itemBuilder: (context, index) {
                final event = eventController.events[index];
                final categoryName =
                    eventController.getCategoryName(event.categoryId ?? '');
               
final formattedDate = event.date != null
    ? DateFormat('MMMM d yyyy').format(DateTime.parse(event.date!))
    : 'Coming Soon';

return Padding(
  padding: const EdgeInsets.only(right: 12),
  child: InkWell(
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
