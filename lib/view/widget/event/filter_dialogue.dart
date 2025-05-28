// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zesta_1/services/event_controller.dart';

// class FilteredEventsGridPage extends StatelessWidget {
//   final String categoryLabel;
//   final EventController eventController = Get.find();

//   FilteredEventsGridPage({super.key, required this.categoryLabel});

//   @override
//   Widget build(BuildContext context) {
//     // Print when the page is built
//     print('🏗️ FilteredEventsGridPage BUILD - Category: $categoryLabel');
//     print('📊 Total events available: ${eventController.allEvents.length}');
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$categoryLabel Events'),
//         backgroundColor: Colors.red, // Make it obvious this is the test version
//         foregroundColor: Colors.white,
//         actions: [
//           // Test button that just prints
//           IconButton(
//             icon: const Icon(Icons.filter_list),
//             onPressed: () {
//               print('🚨 FILTER BUTTON TAPPED! 🚨');
//               print('🚨 FILTER BUTTON TAPPED! 🚨');
//               print('🚨 FILTER BUTTON TAPPED! 🚨');
              
//               // Also try to show a snackbar
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('FILTER BUTTON WORKS!'),
//                   backgroundColor: Colors.green,
//                   duration: Duration(seconds: 2),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.bug_report, size: 100, color: Colors.red),
//               SizedBox(height: 20),
//               Text(
//                 'TEST VERSION ACTIVE',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text('Category: $categoryLabel'),
//               Text('Total Events: ${eventController.allEvents.length}'),
//               SizedBox(height: 40),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.red, width: 2),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       'TAP THE FILTER ICON IN APP BAR',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.red,
//                       ),
//                     ),
//                     Text('Should show green snackbar'),
//                     Text('Should print messages in console'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }