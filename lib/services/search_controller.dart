import 'package:get/get.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/services/event_controller.dart';

class EventSearchController extends GetxController {
  final EventController eventController = Get.find<EventController>();

  // The search query entered by the user
  var searchQuery = ''.obs;

  // The filtered list of events based on the search query
  RxList<EventModel> filteredEvents = <EventModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to both the search query and the events list
    everAll([searchQuery, eventController.events], (_) => _filterEvents());
    // Initial filter
    _filterEvents();
  }

  // Call this when the search text changes
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Filtering logic
  void _filterEvents() {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      filteredEvents.assignAll(eventController.events);
    } else {
      filteredEvents.assignAll(
        eventController.events.where((event) {
          final name = event.name?.toLowerCase() ?? '';
          final category = event.categoryId?.toLowerCase() ?? '';
          final city = event.city?.toLowerCase() ?? '';
          return name.contains(query);
        }).toList(),
      );
    }
  }
}
