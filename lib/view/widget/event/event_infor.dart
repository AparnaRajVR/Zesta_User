
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart'; 
// import 'package:zesta_1/model/event_model.dart';

// class EventInfoBar extends StatelessWidget {
//   final EventModel event;
//   const EventInfoBar({super.key, required this.event});

//   String _formatDate(String? dateStr) {
//     if (dateStr == null) return 'No Date';
//     try {
//       final date = DateTime.parse(dateStr);
//       // Format: Wednesday, 11 June 2025
//       return DateFormat('EEEE, d MMMM y').format(date);
//     } catch (_) {
//       return dateStr;
//     }
//   }

 
// String _formatTime(String? dateStr, String? startTime) {
//   if (dateStr == null || startTime == null) return 'N/A';

//   // Extract date part (handles both ISO 8601 and "yyyy-MM-dd")
//   String datePart = dateStr.contains('T') ? dateStr.split('T')[0] : dateStr;

//   DateTime? startDateTime;
//   List<String> timeFormats = ['HH:mm', 'h:mm a'];

//   for (var format in timeFormats) {
//     try {
//       startDateTime = DateFormat('yyyy-MM-dd $format').parse('$datePart $startTime');
//       break;
//     } catch (_) {
//       continue;
//     }
//   }

//   if (startDateTime != null) {
//     return DateFormat('h:mm a').format(startDateTime);
//   } else {
//     return startTime;
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//           color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _infoItem(Icons.calendar_today_outlined, 'Date', _formatDate(event.date)),
//           _infoItem(Icons.access_time_outlined, 'Time', _formatTimeRange( event.startTime)),
//           _infoItem(Icons.timer_outlined, 'Duration', event.duration ?? 'N/A'),
//         ],
//       ),
//     );
//   }

//   Widget _infoItem(IconData icon, String title, String content) {
//     return Column(
//       children: [
//         Icon(icon, color: Colors.blue.shade600, size: 22),
//         const SizedBox(height: 8),
//         Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
//         const SizedBox(height: 4),
//         Text(content, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:zesta_1/model/event_model.dart';

class EventInfoBar extends StatelessWidget {
  final EventModel event;
  const EventInfoBar({super.key, required this.event});

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'No Date';
    try {
      final date = DateTime.parse(dateStr);
      // Format: Wednesday, 11 June 2025
      return DateFormat('EEEE, d MMMM y').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  String _formatTime(String? dateStr, String? startTime) {
    if (dateStr == null || startTime == null) return 'N/A';

    // Extract date part (handles both ISO 8601 and "yyyy-MM-dd")
    String datePart = dateStr.contains('T') ? dateStr.split('T')[0] : dateStr;

    DateTime? startDateTime;
    List<String> timeFormats = ['HH:mm', 'h:mm a'];

    for (var format in timeFormats) {
      try {
        startDateTime = DateFormat('yyyy-MM-dd $format').parse('$datePart $startTime');
        break;
      } catch (_) {
        continue;
      }
    }

    if (startDateTime != null) {
      return DateFormat('h:mm a').format(startDateTime);
    } else {
      return startTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50, 
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _infoItem(Icons.calendar_today_outlined, 'Date', _formatDate(event.date)),
          _infoItem(Icons.access_time_outlined, 'Time', _formatTime(event.date, event.startTime)),
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
