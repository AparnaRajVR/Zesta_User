// filter_dialog.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zesta_1/services/filter_service.dart';

class FilterDialog extends StatelessWidget {
  final FilterController filterController;
  final String categoryLabel;

  const FilterDialog({super.key, required this.filterController, required this.categoryLabel});

  @override
  Widget build(BuildContext context) {
    DateTime? tempStartDate = filterController.startDate.value;
    DateTime? tempEndDate = filterController.endDate.value;
    double tempMinPrice = filterController.minPrice.value;
    double tempMaxPrice = filterController.maxPrice.value;
    String tempSelectedLocation = filterController.selectedLocation.value;

    return StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('Filters'),
        content: SingleChildScrollView(
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
                onChanged: (val) => setState(() => tempSelectedLocation = val ?? 'All Locations'),
              ),
              const SizedBox(height: 16),

              const Text('Start Date'),
              Row(
                children: [
                  Expanded(
                    child: Text(tempStartDate == null
                        ? 'Any'
                        : DateFormat('yyyy-MM-dd').format(tempStartDate!)),
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
                      if (picked != null) setState(() => tempStartDate = picked);
                    },
                  ),
                  if (tempStartDate != null)
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => tempStartDate = null),
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
                        : DateFormat('yyyy-MM-dd').format(tempEndDate!)),
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
                      if (picked != null) setState(() => tempEndDate = picked);
                    },
                  ),
                  if (tempEndDate != null)
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => tempEndDate = null),
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
  }
}
