

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zesta_1/view/widget/event/category_icon_grid.dart';

class CategoryIconWidget extends StatelessWidget {
  final void Function(String label) onCategoryTap;
  const CategoryIconWidget({super.key, required this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> categories = [
      {'icon': FontAwesomeIcons.music, 'label': 'Music'},
      {'icon': FontAwesomeIcons.futbol, 'label': 'Sports'},
      {'icon': FontAwesomeIcons.microphone, 'label': 'Performance'},
      {'icon': FontAwesomeIcons.bookOpen, 'label': 'Education'},
      {'icon': FontAwesomeIcons.stethoscope, 'label': 'Health'},
      {'icon': FontAwesomeIcons.utensils, 'label': 'Food'},
      {'icon': FontAwesomeIcons.guitar, 'label': 'Concert'},
      {'icon': FontAwesomeIcons.paintbrush, 'label': 'Art'},
      {'icon': FontAwesomeIcons.theaterMasks, 'label': 'Comedy'},
      {'icon': FontAwesomeIcons.bars, 'label': 'See All'},
    ];

    void handleTap(String label) {
      if (label == 'See All') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CategoryGridScreen(
              onCategoryTap: (selectedLabel) {
                // Navigator.of(context).pop(); // Close the grid
                onCategoryTap(selectedLabel); // Call the original callback
              },
            ),
          ),
        );
      } else {
        onCategoryTap(label);
      }
    }

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => handleTap(category['label'] as String),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category['icon'] as IconData,
                    size: 30,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 60,
                    child: Text(
                      category['label'] as String,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}