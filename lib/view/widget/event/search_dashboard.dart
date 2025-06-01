
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/services/search_controller.dart';

class EventSearchPage extends StatelessWidget {
  final EventSearchController controller = Get.find<EventSearchController>();
  final TextEditingController searchController = TextEditingController();

  EventSearchPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Search Events',
          style: TextStyle(color: AppColors.textlight),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
  controller: searchController,
  decoration: InputDecoration(
    hintText: 'Search events...',
    prefixIcon: const Icon(Icons.search, color: AppColors.textlight),
    suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
        ? IconButton(
            icon: const Icon(Icons.clear, color: AppColors.textlight),
            onPressed: () {
              searchController.clear();
              controller.updateSearchQuery('');
              FocusScope.of(context).unfocus(); // Dismiss keyboard
            },
          )
        : const SizedBox()),
    filled: true,
    fillColor: Colors.grey[200],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
  onChanged: controller.updateSearchQuery,
)

          ),
          Expanded(
            child: Obx(() {
              final events = controller.filteredEvents;
              if (events.isEmpty) {
                return const Center(child: Text('No events found.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return EventCard(event: event, controller: controller);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final EventModel event;
  final EventSearchController controller;

  const EventCard({super.key, required this.event, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image (Use first image from images list or placeholder)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: event.images != null && event.images!.isNotEmpty
                  ? Image.network(
                      event.images!.first, // Use the first image
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(),
                    )
                  : _buildPlaceholderImage(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name ?? 'Unnamed Event',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.eventController.getCategoryName(event.categoryId ?? ''),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.city ?? 'Unknown Location',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.date ?? 'No Date',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey[300],
      child: const Icon(
        Icons.event,
        size: 40,
        color: Colors.grey,
      ),
    );
  }
}