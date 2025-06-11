
import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventController extends GetxController {
  var events = <EventModel>[].obs;
  var categoryMap = <String, String>{}.obs;
  var favoriteEvents = <String>[].obs;
  var favoriteEventsList = <EventModel>[].obs;
  Timer? _debounceTimer;

  // Store user-selected categories
  final RxList<String> userSelectedCategories = <String>[].obs;

  List<EventModel> get allEvents => events;

  List<EventModel> get featuredEvents =>
      events.where((e) => e.categoryId == 'featured').toList();

  @override
  void onInit() {
    fetchEvents();
    fetchCategories();
    fetchUserSelectedCategories(); 
    _loadFavorites();
    everAll([events, favoriteEvents], (_) {
      _updateFavoriteEventsList();
    });
    super.onInit();
  }

  //  Fetch user's selected categories from Firestore
  Future<void> fetchUserSelectedCategories() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final doc = await FirebaseFirestore.instance.collection('user_profiles').doc(uid).get();
    final cats = doc.data()?['categories'] as List<dynamic>? ?? [];
    userSelectedCategories.assignAll(cats.cast<String>());
  }

  void fetchEvents() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('events').get();
      // log('Firestore snapshot size: ${snapshot.docs.length}');

      final eventList = snapshot.docs.map((doc) {
        // log('Doc data: ${doc.data()}');
        final data = doc.data();
        data['id'] = doc.id;
        return EventModel.fromMap(data);
      }).toList();

      events.assignAll(eventList);
      log('Events loaded: ${events.length}');
    } catch (e) {
      // log('Error fetching events: $e');
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
      // log('Categories loaded: ${categoryMap.length}');
    } catch (e) {
      // log('Error fetching categories: $e');
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
    // log('Favorite toggled: ${event.id}, Favorites: ${favoriteEvents.length}');

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
      // log('Favorites loaded: ${favoriteEvents.length}');
    } catch (e) {
      // log('Error loading favorites: $e');
    }
  }
  void removeFromFavorites(EventModel event) { 
    favoriteEvents.remove(event.id);           
    _debounceTimer?.cancel();                  
    _debounceTimer = Timer(const Duration(milliseconds: 300), () async { 
      await _saveFavorites();                  
    });                                        
  }                   

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favoriteEvents', favoriteEvents.toList());
      // log('Favorites saved: ${favoriteEvents.length}');
    } catch (e) {
      // log('Error saving favorites: $e');
    }
  }



  List<EventModel> get pastWeekEvents {
    final now = DateTime.now();
    final oneWeekAgo = now.subtract(const Duration(days: 7));
    return events.where((event) {
      final eventDate = _parseEventDate(event.date);
      return eventDate != null &&
          eventDate.isBefore(now) &&
          eventDate.isAfter(oneWeekAgo);
    }).toList();
  }
  //  to parse event.date safely
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

  //  Upcoming events filtered by user interest
 List<EventModel> get upcomingEventsByUserInterest {
  final now = DateTime.now();
  // Convert user-selected category NAMES to their IDs
  final userSelectedCategoryIds = categoryMap.entries
      .where((entry) => userSelectedCategories.contains(entry.value))
      .map((entry) => entry.key)
      .toList();

  return events.where((event) {
    final eventDate = _parseEventDate(event.date);
    final isUpcoming = eventDate != null && 
        !eventDate.isBefore(DateTime(now.year, now.month, now.day));
        
    // If no categories selected, show all upcoming
    if (userSelectedCategoryIds.isEmpty) return isUpcoming;
    
    // Check if event's categoryId matches any selected category ID
    return isUpcoming && 
        userSelectedCategoryIds.contains(event.categoryId);
  }).toList();
}


  // Keep your existing upcomingEvents if you want all upcoming events
  List<EventModel> get upcomingEvents {
    final now = DateTime.now();
    return events.where((event) {
      final eventDate = _parseEventDate(event.date);
      return eventDate != null && !eventDate.isBefore(DateTime(now.year, now.month, now.day));
    }).toList();
  }
}
