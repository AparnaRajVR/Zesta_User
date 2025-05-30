
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/services/event_controller.dart';
import 'package:intl/intl.dart';
import 'package:zesta_1/services/filter_service.dart';
import 'package:zesta_1/view/widget/event/filter_event_card.dart';

class FilteredEventsGridPage extends StatelessWidget {
  final String categoryLabel;
  FilteredEventsGridPage({super.key, required this.categoryLabel});

  final FilterController filterController = Get.put(FilterController());
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  void _showFilterDialog(BuildContext context) {
    // Use temp variables for dialog state
    DateTime? tempStartDate = filterController.startDate.value;
    DateTime? tempEndDate = filterController.endDate.value;
    double tempMinPrice = filterController.minPrice.value;
    double tempMaxPrice = filterController.maxPrice.value;
    String tempSelectedLocation = filterController.selectedLocation.value;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text('Filters'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location filter
                  Text('Location'),
                  DropdownButton<String>(
                    value: tempSelectedLocation,
                    isExpanded: true,
                    items: filterController.availableLocations
                        .map((loc) => DropdownMenuItem(
                              value: loc,
                              child: Text(loc),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() => tempSelectedLocation = val ?? 'All Locations');
                    },
                  ),
                  SizedBox(height: 16),

                  // Date pickers
                  Text('Start Date'),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          tempStartDate == null
                              ? 'Any'
                              : DateFormat('yyyy-MM-dd').format(tempStartDate!),
                        ),
                      ),
                      TextButton(
                        child: Text('Pick'),
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: tempStartDate ?? DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() => tempStartDate = picked);
                          }
                        },
                      ),
                      if (tempStartDate != null)
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () => setState(() => tempStartDate = null),
                        ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('End Date'),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          tempEndDate == null
                              ? 'Any'
                              : DateFormat('yyyy-MM-dd').format(tempEndDate!),
                        ),
                      ),
                      TextButton(
                        child: Text('Pick'),
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: tempEndDate ?? DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() => tempEndDate = picked);
                          }
                        },
                      ),
                      if (tempEndDate != null)
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () => setState(() => tempEndDate = null),
                        ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Price range
                  Text('Price Range (₹${tempMinPrice.toInt()} - ₹${tempMaxPrice.toInt()})'),
                  RangeSlider(
                    min: 0,
                    max: 1000,
                    divisions: 20,
                    values: RangeValues(tempMinPrice, tempMaxPrice),
                    onChanged: (values) {
                      setState(() {
                        tempMinPrice = values.start;
                        tempMaxPrice = values.end;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  filterController.startDate.value = tempStartDate;
                  filterController.endDate.value = tempEndDate;
                  filterController.minPrice.value = tempMinPrice;
                  filterController.maxPrice.value = tempMaxPrice;
                  filterController.selectedLocation.value = tempSelectedLocation;
                  filterController.applyFilters(categoryLabel);
                  Navigator.of(context).pop();
                },
                child: Text('Apply'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ensure filter is initialized only once
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
            icon: Icon(Icons.filter_list),
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
      prefixIcon: Icon(Icons.search),
      border: OutlineInputBorder(),
      suffixIcon: Obx(() => searchQuery.value.isNotEmpty
          ? IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                searchController.clear();
                searchQuery.value = '';
              },
            )
          : SizedBox.shrink()),
    ),
    onChanged: (value) => searchQuery.value = value,
  ),
),

          Obx(() {
            final events = filterController.filteredEvents.where((event) {
              final name = (event.name ?? '').toLowerCase();
              final query = searchQuery.value.toLowerCase();
              return name.contains(query);
            }).toList();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: Row(
                children: [
                  Text(
                    'Found ${events.length} events',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    'Location: ${filterController.selectedLocation.value}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            );
          }),
          Expanded(
            child: Obx(() {
              final events = filterController.filteredEvents.where((event) {
                final name = (event.name ?? '').toLowerCase();
                final query = searchQuery.value.toLowerCase();
                return name.contains(query);
              }).toList();

              if (events.isEmpty) {
                return Center(child: Text('No events found.'));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(12.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return filter_eventCard(event: event);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

