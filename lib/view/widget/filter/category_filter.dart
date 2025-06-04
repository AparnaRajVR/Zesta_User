
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/services/event_controller.dart';
import 'package:zesta_1/services/filter_service.dart';
import 'package:zesta_1/view/widget/filter/filter_event_card.dart';
import 'package:zesta_1/view/widget/filter/filter_dialog.dart';

class FilteredEventsGridPage extends StatelessWidget {
  final String categoryLabel;
  FilteredEventsGridPage({super.key, required this.categoryLabel});

  final FilterController filterController = Get.put(FilterController());
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FilterDialog(
        filterController: filterController,
        categoryLabel: categoryLabel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!filterController.isInitialized) {
      final EventController eventController = Get.find<EventController>();
      filterController.initialize(eventController, categoryLabel);
      filterController.isInitialized = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Events - $categoryLabel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search events',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: Obx(() => searchQuery.value.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          searchQuery.value = '';
                        },
                      )
                    : const SizedBox.shrink()),
              ),
              onChanged: (value) => searchQuery.value = value,
            ),
          ),
          Obx(() {
            final events = _filteredEvents;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: Row(
                children: [
                  Text('Found ${events.length} events', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text('Location: ${filterController.selectedLocation.value}', style: TextStyle(color: Colors.grey[700])),
                ],
              ),
            );
          }),
          Expanded(
            child: Obx(() {
              final events = _filteredEvents;

              if (events.isEmpty) {
                return const Center(child: Text('No events found.'));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(12.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return filter_eventCard(event: events[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  List get _filteredEvents {
    final query = searchQuery.value.toLowerCase();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return filterController.filteredEvents.where((event) {
      final name = (event.name ?? '').toLowerCase();

      DateTime? eventDate;
      if (event.date is DateTime) {
        eventDate = event.date;
      } else if (event.date is String && event.date.isNotEmpty) {
        try {
          eventDate = DateTime.parse(event.date);
        } catch (_) {
          eventDate = null;
        }
      }

      return name.contains(query) &&
          eventDate != null &&
          !eventDate.isBefore(today);
    }).toList();
  }
}
