

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:zesta_1/model/event_model.dart';

class EventController extends GetxController {
  var events = <EventModel>[].obs;
  var categoryMap = <String, String>{}.obs; 

  List<EventModel> get allEvents => events;


  List<EventModel> get featuredEvents => events.where((e) => e.categoryId == 'featured').toList();

  @override
  void onInit() {
    fetchEvents();
    fetchCategories(); 
    super.onInit();
  }

  void fetchEvents() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('events').get();
      log('Firestore snapshot size: ${snapshot.docs.length}'); 

      final eventList = snapshot.docs.map((doc) {
        log('Doc data: ${doc.data()}'); 
        return EventModel.fromMap(doc.data());
      }).toList();

      events.value = eventList;
      log('Events loaded: ${events.length}');
    } catch (e) {
      log('Error fetching events: $e');
    }
  }




void fetchCategories() async {
  final snapshot = await FirebaseFirestore.instance.collection('event_categories').get();
  final map = {
    for (var doc in snapshot.docs) doc.id: doc['name'] as String
  };
  categoryMap.value = map;
}
String getCategoryName(String categoryId) {
  return categoryMap[categoryId] ?? 'Unknown Category';
}

}