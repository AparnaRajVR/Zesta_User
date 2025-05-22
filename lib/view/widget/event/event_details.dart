

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zesta_1/constant/color.dart';
// import 'package:zesta_1/dependency_injection/instance_bind.dart';
// import 'package:zesta_1/model/event_model.dart';
// import 'package:zesta_1/services/event_controller.dart';
// import 'package:zesta_1/view/screen/payment_proceed.dart';
// import 'package:zesta_1/view/widget/event/image_slider.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:zesta_1/view/widget/event/recommented_item.dart';

// class EventDetailsPage extends StatelessWidget {
//   final EventModel event;

//   const EventDetailsPage({super.key, required this.event});

//   String _formatDate(String? dateStr) {
//     if (dateStr == null || dateStr.isEmpty) return 'No Date';
//     try {
//       final date = DateTime.parse(dateStr);
//       final month = _getMonthName(date.month);
//       final weekday = _getWeekdayName(date.weekday);
//       return '$weekday, ${date.day} $month ${date.year}';
//     } catch (e) {
//       return dateStr;
//     }
//   }

//   String _formatTimeRange(String? startTime, String? endTime) {
//     if (startTime == null || startTime.isEmpty) {
//       return endTime == null || endTime.isEmpty
//           ? 'Time not specified'
//           : 'Ends at ${_formatTime(endTime)}';
//     }
//     if (endTime == null || endTime.isEmpty) {
//       return ' ${_formatTime(startTime)}';
//     }
//     return '${_formatTime(startTime)} - ${_formatTime(endTime)}';
//   }

//   String _formatTime(String timeStr) {
//     try {
//       String t = timeStr;
//       if (timeStr.contains('T')) {
//         t = timeStr.split('T')[1];
//       }
//       t = t.split('.').first;
//       final parts = t.split(':');
//       if (parts.length < 2) return timeStr;
//       int hour = int.parse(parts[0]);
//       int minute = int.parse(parts[1]);
//       String period = hour >= 12 ? 'PM' : 'AM';
//       hour = hour % 12;
//       if (hour == 0) hour = 12;
//       return '$hour:${minute.toString().padLeft(2, '0')} $period';
//     } catch (e) {
//       return timeStr;
//     }
//   }

//   String _getMonthName(int month) {
//     const months = [
//       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ];
//     return months[month - 1];
//   }

//   String _getWeekdayName(int weekday) {
//     const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return weekdays[weekday - 1];
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<EventController>();
//     final descriptionController = Get.put(DescriptionController());
//     final screenHeight = MediaQuery.of(context).size.height;
//     final imageHeight = screenHeight * 0.35;
//     final description = event.description ?? 'No Description';

//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       SizedBox(
//                         height: imageHeight,
//                         width: double.infinity,
//                         child: EventImageSlider(
//                           images: event.images ?? [],
//                           height: imageHeight,
//                           borderRadius: BorderRadius.zero,
//                         ),
//                       ),
//                       Positioned(
//                         top: 40,
//                         left: 10,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.3),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: IconButton(
//                             icon: const Icon(Icons.arrow_back, color: Colors.white),
//                             onPressed: () => Navigator.pop(context),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           event.name ?? 'Event Title',
//                           style: const TextStyle(
//                               fontSize: 24, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 24),
//                         Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade50,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: _infoItem(
//                                   icon: MaterialCommunityIcons.calendar_outline,
//                                   title: 'Date',
//                                   content: _formatDate(event.date),
//                                 ),
//                               ),
//                               Container(
//                                 height: 40,
//                                 width: 1,
//                                 color: Colors.grey.shade300,
//                               ),
//                               Expanded(
//                                 child: _infoItem(
//                                   icon: MaterialCommunityIcons.clock_outline,
//                                   title: 'Time',
//                                   content: _formatTimeRange(event.startTime, event.endTime),
//                                 ),
//                               ),
//                               Container(
//                                 height: 40,
//                                 width: 1,
//                                 color: Colors.grey.shade300,
//                               ),
//                               Expanded(
//                                 child: _infoItem(
//                                   icon: MaterialCommunityIcons.timer_outline,
//                                   title: 'Duration',
//                                   content: event.duration ?? 'Not specified',
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: _detailItem(
//                                 icon: MaterialCommunityIcons.map_marker_outline,
//                                 title: 'Location',
//                                 content: event.address ?? 'No Address',
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: _detailItem(
//                                 icon: MaterialCommunityIcons.account_outline,
//                                 title: 'Organizer',
//                                 content: event.organizerName ,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: _detailItem(
//                                 icon: MaterialCommunityIcons.tag_outline,
//                                 title: 'Category',
//                                 content: controller.getCategoryName(event.categoryId ?? ''),
//                               ),
//                             ),
//                             if ((event.ageLimit?.isNotEmpty ?? false)) ...[
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: _detailItem(
//                                   icon: MaterialCommunityIcons.cake_variant_outline,
//                                   title: 'Age Limit',
//                                   content: event.ageLimit!.join(', '),
//                                 ),
//                               ),
//                             ],
//                           ],
//                         ),
//                         if ((event.languages?.isNotEmpty ?? false)) ...[
//                           const SizedBox(height: 16),
//                           _detailItem(
//                             icon: MaterialCommunityIcons.translate,
//                             title: 'Language',
//                             content: event.languages!.join(', '),
//                           ),
//                         ],
//                         const SizedBox(height: 24),
//                         const Text(
//                           'About The Event',
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 12),
//                         Obx(() {
//                           final expanded = descriptionController.expanded.value;
//                           final maxLines = expanded ? null : 3;
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 description,
//                                 style: const TextStyle(fontSize: 14, height: 1.5),
//                                 maxLines: maxLines,
//                                 overflow: maxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
//                               ),
//                               const SizedBox(height: 8),
//                               GestureDetector(
//                                 onTap: descriptionController.toggle,
//                                 child: Text(
//                                   expanded ? 'Read Less' : 'Read More',
//                                   style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           );
//                         }),
//                         const SizedBox(height: 30),
//                         // const Text(
//                         //   'You May Also Like',
//                         //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         // ),
//                         // const SizedBox(height: 12),
//                         RecommendedItemsWidget(
//                           events: controller.allEvents,
//                         ),
//                         const SizedBox(height: 16),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 1,
//                   blurRadius: 5,
//                   offset: const Offset(0, -2),
//                 ),
//               ],
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           '₹${event.ticketPrice?.toStringAsFixed(0) ?? '299'}',
//                           style: const TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
                        
//                       ],
//                     ),
//                   ],
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Get.to(() => BookingPage(event: event));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primary,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 40, vertical: 14),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8)),
//                     elevation: 2,
//                   ),
//                   child: const Text(
//                     'Book Now',
//                     style: TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _infoItem({
//     required IconData icon,
//     required String title,
//     required String content,
//   }) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, color: AppColors.primary, size: 22),
//         const SizedBox(height: 8),
//         Text(
//           title,
//           style: TextStyle(
//             color: Colors.grey.shade600,
//             fontSize: 12,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           content,
//           style: const TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 13,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }

//   Widget _detailItem({
//     required IconData icon,
//     required String title,
//     required String content,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, color: AppColors.primary, size: 20),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   color: Colors.grey.shade600,
//                   fontSize: 12,
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Text(
//                 content,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 13,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/dependency_injection/instance_bind.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/services/event_controller.dart';
import 'package:zesta_1/view/screen/payment_proceed.dart';
import 'package:zesta_1/view/widget/event/image_slider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:zesta_1/view/widget/event/recommented_item.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel event;

  const EventDetailsPage({super.key, required this.event, required String eventId});

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'No Date';
    try {
      final date = DateTime.parse(dateStr);
      final month = _getMonthName(date.month);
      final weekday = _getWeekdayName(date.weekday);
      return '$weekday, ${date.day} $month ${date.year}';
    } catch (e) {
      return dateStr;
    }
  }

  String _formatTimeRange(String? startTime, String? endTime) {
    if (startTime == null || startTime.isEmpty) {
      return endTime == null || endTime.isEmpty
          ? 'Time not specified'
          : 'Ends at ${_formatTime(endTime)}';
    }
    if (endTime == null || endTime.isEmpty) {
      return ' ${_formatTime(startTime)}';
    }
    return '${_formatTime(startTime)} - ${_formatTime(endTime)}';
  }

  String _formatTime(String timeStr) {
    try {
      String t = timeStr;
      if (timeStr.contains('T')) {
        t = timeStr.split('T')[1];
      }
      t = t.split('.').first;
      final parts = t.split(':');
      if (parts.length < 2) return timeStr;
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      String period = hour >= 12 ? 'PM' : 'AM';
      hour = hour % 12;
      if (hour == 0) hour = 12;
      return '$hour:${minute.toString().padLeft(2, '0')} $period';
    } catch (e) {
      return timeStr;
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  String _getWeekdayName(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventController>();
    final descriptionController = Get.put(DescriptionController());
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.35;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: imageHeight,
                        width: double.infinity,
                        child: EventImageSlider(
                          images: event.images ?? [],
                          height: imageHeight,
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40,
                        right: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Obx(() {
                            final isFavorited = controller.favoriteEvents
                                .contains(event.id)
                                .obs;
                            return IconButton(
                              icon: Icon(
                                isFavorited.value
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorited.value
                                    ? Colors.red
                                    : Colors.white,
                              ),
                              onPressed: () {
                                controller.toggleFavorite(event);
                              },
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.name ?? 'Event Title',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: _infoItem(
                                  icon: MaterialCommunityIcons.calendar_outline,
                                  title: 'Date',
                                  content: _formatDate(event.date),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 1,
                                color: Colors.grey.shade300,
                              ),
                              Expanded(
                                child: _infoItem(
                                  icon: MaterialCommunityIcons.clock_outline,
                                  title: 'Time',
                                  content: _formatTimeRange(event.startTime, event.endTime),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 1,
                                color: Colors.grey.shade300,
                              ),
                              Expanded(
                                child: _infoItem(
                                  icon: MaterialCommunityIcons.timer_outline,
                                  title: 'Duration',
                                  content: event.duration ?? 'Not specified',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: _detailItem(
                                icon: MaterialCommunityIcons.map_marker_outline,
                                title: 'Location',
                                content: event.address ?? 'No Address',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _detailItem(
                                icon: MaterialCommunityIcons.account_outline,
                                title: 'Organizer',
                                content: event.organizerName,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _detailItem(
                                icon: MaterialCommunityIcons.tag_outline,
                                title: 'Category',
                                content: controller.getCategoryName(event.categoryId ?? ''),
                              ),
                            ),
                            if ((event.ageLimit?.isNotEmpty ?? false)) ...[
                              const SizedBox(width: 16),
                              Expanded(
                                child: _detailItem(
                                  icon: MaterialCommunityIcons.cake_variant_outline,
                                  title: 'Age Limit',
                                  content: event.ageLimit!.join(', '),
                                ),
                              ),
                            ],
                          ],
                        ),
                        if ((event.languages?.isNotEmpty ?? false)) ...[
                          const SizedBox(height: 16),
                          _detailItem(
                            icon: MaterialCommunityIcons.translate,
                            title: 'Language',
                            content: event.languages!.join(', '),
                          ),
                        ],
                        const SizedBox(height: 24),
                        const Text(
                          'About The Event',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Obx(() {
                          final expanded = descriptionController.expanded.value;
                          final maxLines = expanded ? null : 3;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.description ?? 'No Description',
                                style: const TextStyle(fontSize: 14, height: 1.5),
                                maxLines: maxLines,
                                overflow: maxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: descriptionController.toggle,
                                child: Text(
                                  expanded ? 'Read Less' : 'Read More',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        const SizedBox(height: 30),
                        RecommendedItemsWidget(
                          events: controller.allEvents,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '₹${event.ticketPrice?.toStringAsFixed(0) ?? '299'}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => BookingPage(event: event));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoItem({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _detailItem({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                content,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}