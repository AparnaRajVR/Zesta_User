import 'package:flutter/material.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/model/event_model.dart';

class EventDetailsCard extends StatelessWidget {
  final EventModel event;
  final String Function(String?) formatDate;
  final String Function(String?) formatTime;

  const EventDetailsCard({
    super.key,
    required this.event,
    required this.formatDate,
    required this.formatTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.name ?? 'Event Name',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.second),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.location_on, color: AppColors.primary, size: 16),
                SizedBox(width: 4),
                Text(event.city ?? 'Location TBA', style: TextStyle(color: AppColors.textaddn)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, color: AppColors.primary, size: 16),
                SizedBox(width: 4),
                Text(formatDate(event.date), style: TextStyle(color: AppColors.textaddn)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, color: AppColors.primary, size: 16),
                SizedBox(width: 4),
                Text(formatTime(event.startTime), style: TextStyle(color: AppColors.textaddn)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
