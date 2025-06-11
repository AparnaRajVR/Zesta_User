
import 'package:flutter/material.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/view/widget/event/back_button.dart';
import 'package:zesta_1/view/widget/event/book_button.dart';
import 'package:zesta_1/view/widget/event/details_event.dart';
import 'package:zesta_1/view/widget/event/event_age_widget.dart';
import 'package:zesta_1/view/widget/event/event_infor.dart';
import 'package:zesta_1/view/widget/event/expand_event.dart';
import 'package:zesta_1/view/widget/event/favorite_icon.dart';
import 'package:zesta_1/view/widget/event/image_slider.dart';
import 'package:zesta_1/view/widget/event/organizer_location.dart';

import 'package:zesta_1/constant/color.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel event;

  const EventDetailsPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<EventController>();
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
                      const Positioned(
                        top: 40,
                        left: 10,
                        child: EventBackButton(),
                      ),
                      Positioned(
                        top: 40,
                        right: 10,
                        child: EventFavoriteIcon(event: event),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: AppColors.textlight,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.name ?? 'Event Title',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 24),
                        EventInfoBar(event: event),
                        const SizedBox(height: 20),
                        EventLocationOrganizerRow(event: event),
                        const SizedBox(height: 16),
                        EventCategoryAgeLimitRow(event: event),
                        if ((event.languages?.isNotEmpty ?? false)) ...[
                          const SizedBox(height: 16),
                          eventDetailItem(
                            icon: Icons.translate,
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
                       const SizedBox(height: 12),
                       ExpandableDescription(description: event.description ?? 'No Description'),

                        const SizedBox(height: 30),
                        // RecommendedItemsWidget(events: controller.allEvents),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomBookButton(event: event),
        ],
      ),
    );
  }
}
