

import 'package:flutter/material.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/view/screen/event_details.dart'; 

// ignore: camel_case_types
class filter_eventCard extends StatelessWidget {
  final EventModel event;

  const filter_eventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = (event.images != null && event.images!.isNotEmpty)
        ? event.images!.first
        : null;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(event: event,),
          ),
        );
      },
      child: Card(
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            imageUrl != null
                ? Image.network(imageUrl, height: 120, fit: BoxFit.cover)
                : Container(
                    height: 120,
                    color: Colors.grey[300],
                    child: Icon(Icons.event, size: 60, color: Colors.grey),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                event.name ?? 'No Name',
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                event.city ?? '',
                style: TextStyle(color: Colors.grey[600]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                (event.ticketPrice == null || event.ticketPrice == 0)
                    ? 'Free'
                    : '₹${event.ticketPrice!.toStringAsFixed(0)}',
                style: TextStyle(
                  color: (event.ticketPrice == null || event.ticketPrice == 0)
                      ? Colors.green
                      : Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
