import 'package:flutter/material.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/view/widget/event/details_event.dart';

class EventLocationOrganizerRow extends StatelessWidget {
  final EventModel event;

  const EventLocationOrganizerRow({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: eventDetailItem(
            icon: Icons.location_on_outlined,
            title: 'Location',
            content: event.address ?? 'No Address',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: eventDetailItem(
            icon: Icons.person_outline,
            title: 'Organizer',
            content: event.organizerName,
          ),
        ),
      ],
    );
  }
}
