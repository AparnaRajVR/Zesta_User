
import 'package:get/get.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/services/event_controller.dart';

class EventSearchController extends GetxController {
  final EventController eventController = Get.find<EventController>();
  var searchQuery = ''.obs;
  RxList<EventModel> filteredEvents = <EventModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with all events
    filteredEvents.assignAll(eventController.events);
    // Listen to search query changes
    ever(searchQuery, (_) => _filterEvents());
    // Listen to events list changes
    ever(eventController.events, (_) => _filterEvents());
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void _filterEvents() {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      filteredEvents.assignAll(eventController.events);
    } else {
      filteredEvents.assignAll(
        eventController.events.where((event) {
          final name = event.name?.toLowerCase() ?? '';
          final city = event.city?.toLowerCase() ?? '';
          final description = event.description?.toLowerCase() ?? '';
          final categoryName = eventController
              .getCategoryName(event.categoryId ?? '')
              .toLowerCase();
          return name.contains(query) ||
              city.contains(query) ||
              description.contains(query) ||
              categoryName.contains(query);
        }).toList(),
      );
    }
  }
}