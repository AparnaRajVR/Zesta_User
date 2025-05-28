import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/services/categories_controller.dart';

class CategorySelectPage extends StatelessWidget {
  CategorySelectPage({super.key});

  final CategorySelectController controller = Get.put(CategorySelectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tell us your interested areas")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select the categories you are interested in:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.categories.isEmpty) {
                  return const Center(child: Text("No categories found."));
                }
                return ListView.builder(
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final cat = controller.categories[index];
                    return ListTile(
                      title: Text(cat['name']),
                      trailing: Obx(() => Checkbox(
                        value: controller.selectedCategories.contains(cat['name']),
                        onChanged: (_) => controller.toggleCategory(cat['name']),
                      )),
                      onTap: () => controller.toggleCategory(cat['name']),
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.saveCategoriesAndProceed,
                child: const Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
