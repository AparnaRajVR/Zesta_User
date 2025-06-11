// import 'package:flutter/material.dart';
// import 'package:zesta_1/model/event_model.dart';

// class RecommendedItemsDetail extends StatelessWidget {
//   final List<EventModel> events;

//   const RecommendedItemsDetail({super.key, required this.events});

//   @override
//   Widget build(BuildContext context) {
//     if (events.isEmpty) return const SizedBox.shrink();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Recommended for You',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 150,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemCount: events.length,
//             separatorBuilder: (_, __) => const SizedBox(width: 12),
//             itemBuilder: (context, index) {
//               final e = events[index];
//               return Container(
//                 width: 140,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   image: DecorationImage(
//                     image: NetworkImage(e.images?.first ?? ''),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     padding: const EdgeInsets.all(6),
//                     decoration: const BoxDecoration(
//                       color: Colors.black54,
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(12),
//                           bottomRight: Radius.circular(12)),
//                     ),
//                     child: Text(
//                       e.name ?? '',
//                       style: const TextStyle(color: Colors.white),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
