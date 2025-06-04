import 'package:flutter/material.dart';

class EventDetailsImageSlider extends StatelessWidget {
  final List<String> images;
  final double height;
  final BorderRadius borderRadius;

  const EventDetailsImageSlider({
    super.key,
    required this.images,
    this.height = 250,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return Container(
        height: height,
        color: Colors.grey.shade300,
        child: const Center(child: Text('No images')),
      );
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Image.network(
            images[index],
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: Colors.grey, child: const Center(child: Icon(Icons.broken_image))),
          );
        },
      ),
    );
  }
}
