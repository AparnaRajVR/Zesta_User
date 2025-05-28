
import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zesta_1/model/event_model.dart';

class EventController extends GetxController {
  var events = <EventModel>[].obs;
  var categoryMap = <String, String>{}.obs;
  var favoriteEvents = <String>[].obs;
  var favoriteEventsList = <EventModel>[].obs;
  Timer? _debounceTimer;

  List<EventModel> get allEvents => events;

  List<EventModel> get featuredEvents =>
      events.where((e) => e.categoryId == 'featured').toList();

  @override
  void onInit() {
    fetchEvents();
    fetchCategories();
    _loadFavorites();
    everAll([events, favoriteEvents], (_) {
      _updateFavoriteEventsList();
      // log('FavoriteEventsList updated: ${favoriteEventsList.length}');
    });
    super.onInit();
  }

  void fetchEvents() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('events').get();
      log('Firestore snapshot size: ${snapshot.docs.length}');

      final eventList = snapshot.docs.map((doc) {
        log('Doc data: ${doc.data()}');
        final data = doc.data();
        data['id'] = doc.id;
        return EventModel.fromMap(data);
      }).toList();

      events.assignAll(eventList);
      log('Events loaded: ${events.length}');
    } catch (e) {
      log('Error fetching events: $e');
    }
  }

  void fetchCategories() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('event_categories').get();
      final map = {
        for (var doc in snapshot.docs) doc.id: doc['name'] as String
      };
      categoryMap.assignAll(map);
      log('Categories loaded: ${categoryMap.length}');
    } catch (e) {
      log('Error fetching categories: $e');
    }
  }

  String getCategoryName(String categoryId) {
    return categoryMap[categoryId] ?? 'Unknown Category';
  }

  void toggleFavorite(EventModel event) {
    if (favoriteEvents.contains(event.id)) {
      favoriteEvents.remove(event.id);
    } else {
      favoriteEvents.add(event.id);
    }
    log('Favorite toggled: ${event.id}, Favorites: ${favoriteEvents.length}');

    // Manual debouncing for saving favorites
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      await _saveFavorites();
    });
  }

  void _updateFavoriteEventsList() {
    favoriteEventsList.assignAll(
      events.where((event) => favoriteEvents.contains(event.id)).toList(),
    );
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = prefs.getStringList('favoriteEvents') ?? [];
      favoriteEvents.assignAll(favorites);
      log('Favorites loaded: ${favoriteEvents.length}');
    } catch (e) {
      log('Error loading favorites: $e');
    }
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favoriteEvents', favoriteEvents.toList());
      log('Favorites saved: ${favoriteEvents.length}');
    } catch (e) {
      log('Error saving favorites: $e');
    }
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }
  void filterEventsByLabel(String label) {
  final matchedCategoryId = categoryMap.entries
      .firstWhere((entry) => entry.value.toLowerCase() == label.toLowerCase(),
          orElse: () => const MapEntry('', ''))
      .key;

  if (matchedCategoryId.isNotEmpty) {
    events.assignAll(allEvents.where((e) => e.categoryId == matchedCategoryId));
  } else {
    events.assignAll(allEvents); // Fallback to all
  }
}
void searchEvents(String query) {
  // If you want to search within the currently filtered list (e.g. by category), use 'events'
  // If you want to search within all events, use 'allEvents'
  if (query.isEmpty) {
    // If you want to reset to category-filtered events:
    if (_lastCategoryLabel != null) {
      filterEventsByLabel(_lastCategoryLabel!);
    } else {
      events.assignAll(allEvents);
    }
    return;
  }

  final lowerQuery = query.toLowerCase();
  final filtered = events.where((event) {
    final name = event.name?.toLowerCase() ?? '';
    final desc = event.description?.toLowerCase() ?? '';
    final city = event.city?.toLowerCase() ?? '';
    final organizer = event.organizerName.toLowerCase();
    return name.contains(lowerQuery) ||
        desc.contains(lowerQuery) ||
        city.contains(lowerQuery) ||
        organizer.contains(lowerQuery);
  }).toList();

  events.assignAll(filtered);
}


String? _lastCategoryLabel;



List<EventModel> get pastWeekEvents {
  final now = DateTime.now();
  final oneWeekAgo = now.subtract(const Duration(days: 7));
  return events.where((event) {
    final eventDate = _parseEventDate(event.date);
    // Only include events that happened in the last 7 days (before now)
    return eventDate != null &&
        eventDate.isBefore(now) &&
        eventDate.isAfter(oneWeekAgo);
  }).toList();
}

// Helper to parse event.date safely
DateTime? _parseEventDate(dynamic date) {
  if (date == null) return null;
  if (date is DateTime) return date;
  if (date is String && date.isNotEmpty) {
    try {
      return DateTime.parse(date);
    } catch (_) {
      return null;
    }
  }
  return null;
}

}