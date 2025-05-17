// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:zesta_1/model/event_model.dart';

// class FeaturedEventsListWidget extends StatelessWidget {
//   final List<EventModel> events;

//   const FeaturedEventsListWidget({super.key, required this.events});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Featured Events",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 12),
//         ListView.builder(
//           shrinkWrap: true,
//           // physics: const NeverScrollableScrollPhysics(),
//           itemCount: events.length,
//           itemBuilder: (context, index) {
//             final event = events[index];
//             log("Featured Event: ${event.name}, Images: ${event.images}");
//             return Card(
//               margin: const EdgeInsets.symmetric(vertical: 8),
//               child: ListTile(
//                 leading: event.images != null && event.images!.isNotEmpty
//                     ? Image.network(
//                         event.images!.first,
//                         width: 50,
//                         height: 50,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) =>
//                             const Icon(Icons.error),
//                       )
//                     : const Icon(Icons.event),
//                 title: Text(event.name ?? 'Unnamed Event'),
//                 subtitle: Text(
//                   'Date: ${event.date?.toString().split(' ')[0] ?? 'N/A'} | Price: \$${event.ticketPrice?.toStringAsFixed(2) ?? 'N/A'}',
//                 ),
//                 onTap: () {
//                   log('Tapped event: ${event.name}');
//                 },
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
