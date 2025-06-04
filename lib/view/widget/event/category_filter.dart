

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zesta_1/services/event_controller.dart';
import 'package:zesta_1/services/filter_service.dart';
import 'package:zesta_1/view/widget/event/filter_event_card.dart';

class FilteredEventsGridPage extends StatelessWidget {
  final String categoryLabel;
  FilteredEventsGridPage({super.key, required this.categoryLabel});

  final FilterController filterController = Get.put(FilterController());
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  void _showFilterDialog(BuildContext context) {
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
            title: const Text('Filters'),
            content: _buildFilterDialogContent(
              context,
              setState,
              tempStartDate,
              tempEndDate,
              tempMinPrice,
              tempMaxPrice,
              tempSelectedLocation,
              (start) => tempStartDate = start,
              (end) => tempEndDate = end,
              (min) => tempMinPrice = min,
              (max) => tempMaxPrice = max,
              (loc) => tempSelectedLocation = loc,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
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
                child: const Text('Apply'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterDialogContent(
    BuildContext context,
    void Function(void Function()) setState,
    DateTime? tempStartDate,
    DateTime? tempEndDate,
    double tempMinPrice,
    double tempMaxPrice,
    String tempSelectedLocation,
    void Function(DateTime?) onStartDateChange,
    void Function(DateTime?) onEndDateChange,
    void Function(double) onMinPriceChange,
    void Function(double) onMaxPriceChange,
    void Function(String) onLocationChange,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Location'),
          DropdownButton<String>(
            value: tempSelectedLocation,
            isExpanded: true,
            items: filterController.availableLocations
                .map((loc) => DropdownMenuItem(value: loc, child: Text(loc)))
                .toList(),
            onChanged: (val) => setState(() => onLocationChange(val ?? 'All Locations')),
          ),
          const SizedBox(height: 16),

          const Text('Start Date'),
          Row(
            children: [
              Expanded(
                child: Text(tempStartDate == null
                    ? 'Any'
                    : DateFormat('yyyy-MM-dd').format(tempStartDate)),
              ),
              TextButton(
                child: const Text('Pick'),
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: tempStartDate ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => onStartDateChange(picked));
                },
              ),
              if (tempStartDate != null)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => setState(() => onStartDateChange(null)),
                ),
            ],
          ),
          const SizedBox(height: 8),

          const Text('End Date'),
          Row(
            children: [
              Expanded(
                child: Text(tempEndDate == null
                    ? 'Any'
                    : DateFormat('yyyy-MM-dd').format(tempEndDate)),
              ),
              TextButton(
                child: const Text('Pick'),
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: tempEndDate ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => onEndDateChange(picked));
                },
              ),
              if (tempEndDate != null)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => setState(() => onEndDateChange(null)),
                ),
            ],
          ),
          const SizedBox(height: 16),

          Text('Price Range (₹${tempMinPrice.toInt()} - ₹${tempMaxPrice.toInt()})'),
          RangeSlider(
            min: 0,
            max: 1000,
            divisions: 20,
            values: RangeValues(tempMinPrice, tempMaxPrice),
            onChanged: (values) {
              setState(() {
                onMinPriceChange(values.start);
                onMaxPriceChange(values.end);
              });
            },
          ),
        ],
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
    return filterController.filteredEvents.where((event) {
      final name = (event.name ?? '').toLowerCase();
      return name.contains(query);
    }).toList();
  }
}
