import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zesta_1/services/filter_service.dart';

class EventFilterDialog extends StatelessWidget {
  final List<String> locations;
  final EventFilterController controller = Get.find();

  EventFilterDialog({Key? key, required this.locations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Filter Events', style: Theme.of(context).textTheme.titleLarge),

              SizedBox(height: 20),

              // Location Dropdown
              Obx(() => DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Location'),
                    value: controller.selectedLocation.value.isEmpty
                        ? null
                        : controller.selectedLocation.value,
                    items: locations
                        .map((loc) => DropdownMenuItem(
                              value: loc,
                              child: Text(loc),
                            ))
                        .toList(),
                    onChanged: (val) => controller.selectedLocation.value = val ?? '',
                  )),
              SizedBox(height: 16),

              // Price Filter
              Obx(() => Row(
                    children: [
                      Text('Price:'),
                      SizedBox(width: 16),
                      ChoiceChip(
                        label: Text('All'),
                        selected: controller.isFree.value == null,
                        onSelected: (_) => controller.isFree.value = null,
                      ),
                      SizedBox(width: 8),
                      ChoiceChip(
                        label: Text('Free'),
                        selected: controller.isFree.value == true,
                        onSelected: (_) => controller.isFree.value = true,
                      ),
                      SizedBox(width: 8),
                      ChoiceChip(
                        label: Text('Paid'),
                        selected: controller.isFree.value == false,
                        onSelected: (_) => controller.isFree.value = false,
                      ),
                    ],
                  )),
              SizedBox(height: 16),

              // Distance Sort
              Obx(() => Row(
                    children: [
                      Text('Sort by Distance:'),
                      SizedBox(width: 16),
                      ChoiceChip(
                        label: Text('Nearest'),
                        selected: controller.distanceSort.value == 'nearest',
                        onSelected: (_) => controller.distanceSort.value = 'nearest',
                      ),
                      SizedBox(width: 8),
                      ChoiceChip(
                        label: Text('Farthest'),
                        selected: controller.distanceSort.value == 'farthest',
                        onSelected: (_) => controller.distanceSort.value = 'farthest',
                      ),
                    ],
                  )),
              SizedBox(height: 16),

              // Date Filter
              Obx(() => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Date:'),
                    subtitle: Text(
                      controller.selectedDate.value == null
                          ? 'Any'
                          : DateFormat('yyyy-MM-dd').format(controller.selectedDate.value!),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime now = DateTime.now();
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: controller.selectedDate.value ?? now,
                          firstDate: now.subtract(Duration(days: 365)),
                          lastDate: now.add(Duration(days: 365)),
                        );
                        if (picked != null) {
                          controller.selectedDate.value = picked;
                        }
                      },
                    ),
                  )),

              SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Optionally clear filters here
                      controller.selectedLocation.value = '';
                      controller.isFree.value = null;
                      controller.distanceSort.value = '';
                      controller.selectedDate.value = null;
                      Navigator.of(context).pop();
                    },
                    child: Text('Clear'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // You can trigger your filtering logic here or after dialog closes
                    },
                    child: Text('Apply'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
