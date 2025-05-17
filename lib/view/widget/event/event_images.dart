
// import 'package:flutter/material.dart';
// import 'package:zesta_1/model/event_model.dart';

// class EventImagesListWidget extends StatelessWidget {
//   final List<EventModel> events;

//   const EventImagesListWidget({super.key, required this.events});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Event Images",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 12),
//         ListView.builder(
//           shrinkWrap: true,
//           // physics: const NeverScrollableScrollPhysics(),
//           itemCount: events.length,
//           itemBuilder: (context, index) {
//             final event = events[index];
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   event.name ?? 'Unnamed Event',
//                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(height: 8),
//                 if (event.images != null && event.images!.isNotEmpty)
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: event.images!
//                           .map((imageUrl) => Padding(
//                                 padding: const EdgeInsets.only(right: 8),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.network(
//                                     imageUrl,
//                                     height: 150,
//                                     width: 100,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) => Container(
//                                       height: 150,
//                                       width: 100,
//                                       color: Colors.grey[200],
//                                       child: const Center(child: Icon(Icons.error)),
//                                     ),
//                                   ),
//                                 ),
//                               ))
//                           .toList(),
//                     ),
//                   )
//                 else
//                   const Padding(
//                     padding: EdgeInsets.only(bottom: 8),
//                     child: Text('No images available'),
//                   ),
//                 const SizedBox(height: 16),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
