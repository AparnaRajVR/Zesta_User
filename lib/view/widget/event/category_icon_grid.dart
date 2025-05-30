import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryGridScreen extends StatelessWidget {
  final void Function(String label) onCategoryTap;

  const CategoryGridScreen({super.key, required this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    // The same categories, but without "See All"
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
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('All Categories')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.pop(context); // Close the grid screen
              onCategoryTap(category['label'] as String);
            },
            child: Card(
              elevation: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category['icon'] as IconData,
                    size: 36,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['label'] as String,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
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
