

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zesta_1/services/event_controller.dart';

class FilteredEventsGridPage extends StatelessWidget {
  final String categoryLabel;
  final EventController eventController = Get.find();

  FilteredEventsGridPage({super.key, required this.categoryLabel});

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM dd, yyyy').format(date); 
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredEvents = eventController.allEvents.where((event) {
      final catId = event.categoryId;
      final catName = eventController.getCategoryName(catId ?? '');
      return catName.toLowerCase() == categoryLabel.toLowerCase();
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryLabel Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          childAspectRatio: 0.8, 
          crossAxisSpacing: 8, 
          mainAxisSpacing: 8,
        ),
        itemCount: filteredEvents.length,
        itemBuilder: (context, index) {
          final event = filteredEvents[index];
          return Card(
            child: Column(
              children: [
                if (event.images != null && event.images!.isNotEmpty)
                  Image.network(event.images!.first, height: 100, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    event.name ?? 'No Name',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(formatDate(event.date)),
                Text(event.city ?? '', overflow: TextOverflow.ellipsis),
              ],
            ),
          );
        },
      ),
    );
  }
}
