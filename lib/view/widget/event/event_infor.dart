import 'package:flutter/material.dart';
import 'package:zesta_1/model/event_model.dart';

class EventInfoBar extends StatelessWidget {
  final EventModel event;
  const EventInfoBar({super.key, required this.event});

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'No Date';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year}';
    } catch (_) {
      return dateStr ;
    }
  }

  String _formatTimeRange(String? startTime, String? endTime) {
    return '${startTime ?? 'N/A'} - ${endTime ?? 'N/A'}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _infoItem(Icons.calendar_today_outlined, 'Date', _formatDate(event.date)),
          _infoItem(Icons.access_time_outlined, 'Time', _formatTimeRange(event.startTime, event.endTime)),
          _infoItem(Icons.timer_outlined, 'Duration', event.duration ?? 'N/A'),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String title, String content) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue.shade600, size: 22),
        const SizedBox(height: 8),
        Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        const SizedBox(height: 4),
        Text(content, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      ],
    );
  }
}
