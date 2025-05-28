
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zesta_1/services/event_controller.dart';
import 'package:zesta_1/services/filter_service.dart';

class FilteredEventsGridPage extends StatelessWidget {
  final String categoryLabel;
  final EventController eventController = Get.find();
  final FilterController filterController = Get.put(FilterController());
  final TextEditingController searchController = TextEditingController();


  FilteredEventsGridPage({super.key, required this.categoryLabel});

  @override
  Widget build(BuildContext context) {
    filterController.initialize(eventController, categoryLabel);

    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryLabel Events'),
        actions: [
          IconButton(
  icon: const Icon(Icons.search),
  onPressed: () {
    final query = searchController.text; // Get the text from your search field
       eventController.searchEvents(query); }
),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: Obx(() {
        final filteredEvents = filterController.filteredEvents;
        final selectedLocation = filterController.selectedLocation.value;
        final startDate = filterController.startDate.value;
        final endDate = filterController.endDate.value;
        final minPrice = filterController.minPrice.value;
        final maxPrice = filterController.maxPrice.value;
        final includeFreeEvents = filterController.includeFreeEvents.value;

        return Column(
          children: [
            if (selectedLocation != 'All Locations' ||
                startDate != null ||
                endDate != null ||
                minPrice > 0 ||
                maxPrice < 1000 ||
                !includeFreeEvents)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.filter_list, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Filters applied • ${filteredEvents.length} events found',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                    TextButton(
                      onPressed: () => filterController.clearFilters(categoryLabel),
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: filteredEvents.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.event_busy, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No events found',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Try adjusting your filters',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
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
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: event.images != null && event.images!.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                          child: Image.network(
                                            event.images!.first,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Center(
                                                child: Icon(Icons.image_not_supported),
                                              );
                                            },
                                          ),
                                        )
                                      : const Center(
                                          child: Icon(Icons.event, size: 40),
                                        ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        event.name ?? 'No Name',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        // maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                     
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  event.city ?? '',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                           Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            event.ticketPrice == null || event.ticketPrice == 0
                                                ? 'Free'
                                                : '\$${event.ticketPrice!.toInt()}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.green.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }

  void _showFilterDialog(BuildContext context) {
    final fc = filterController;
    showDialog(
      context: context,
      builder: (context) {
        return Obx(
          () => Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Filter Events', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Location'),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: fc.selectedLocation.value,
                                isExpanded: true,
                                items: fc.availableLocations.map((location) {
                                  return DropdownMenuItem(
                                    value: location,
                                    child: Text(location),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  fc.selectedLocation.value = value!;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildSectionTitle('Date Range'),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDatePicker(
                                  context,
                                  'Start Date',
                                  fc.startDate.value,
                                  (date) => fc.startDate.value = date,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildDatePicker(
                                  context,
                                  'End Date',
                                  fc.endDate.value,
                                  (date) => fc.endDate.value = date,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildSectionTitle('Price Range'),
                          CheckboxListTile(
                            title: const Text('Include Free Events'),
                            value: fc.includeFreeEvents.value,
                            onChanged: (value) => fc.includeFreeEvents.value = value!,
                            contentPadding: EdgeInsets.zero,
                          ),
                          const SizedBox(height: 10),
                          Text('Min Price: \$${fc.minPrice.value.toInt()}'),
                          Slider(
                            value: fc.minPrice.value,
                            min: 0,
                            max: 500,
                            divisions: 50,
                            onChanged: (value) {
                              fc.minPrice.value = value;
                              if (fc.minPrice.value > fc.maxPrice.value) {
                                fc.maxPrice.value = fc.minPrice.value;
                              }
                            },
                          ),
                          Text('Max Price: \$${fc.maxPrice.value.toInt()}'),
                          Slider(
                            value: fc.maxPrice.value,
                            min: 0,
                            max: 1000,
                            divisions: 100,
                            onChanged: (value) {
                              fc.maxPrice.value = value;
                              if (fc.maxPrice.value < fc.minPrice.value) {
                                fc.minPrice.value = fc.maxPrice.value;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => fc.clearFilters(categoryLabel),
                          child: const Text('Clear All'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            fc.applyFilters(categoryLabel);
                          },
                          child: const Text('Apply Filters'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context, String label, DateTime? date, Function(DateTime?) onChanged) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (picked != null) {
          onChanged(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(
              date != null ? DateFormat.yMMMd().format(date) : 'Select date',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

 dynamic formatDate(DateTime? date) {
    if (date == null) return 'No Date';
    return DateFormat.yMMMd().format(date);
  }
}

