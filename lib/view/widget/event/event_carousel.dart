
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zesta_1/model/event_model.dart';
import 'package:zesta_1/view/widget/event/image_slider.dart';

class EventCarousel extends StatelessWidget {
  final List<EventModel> events;

  const EventCarousel({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 190.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: events.map((event) {
        return EventImageSlider(
          images: event.images ?? [],
          height: 190,
          borderRadius: BorderRadius.circular(12),
        );
      }).toList(),
    );
  }
}
