
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zesta_1/dependency_injection/image_controller.dart';

// class EventImageSlider extends StatelessWidget {
//   final List<String> images;
//   final double? height;
//   final BorderRadius? borderRadius;

//   EventImageSlider({
//     super.key,
//     required this.images,
//     this.height,
//     this.borderRadius,
//   });

//   final ImageSliderController controller = Get.put(ImageSliderController());

//   @override
//   Widget build(BuildContext context) {
//     if (images.isEmpty) {
//       return Container(
//         height: height ?? 180,
//         decoration: BoxDecoration(
//           color: Colors.grey[300],
//           borderRadius: borderRadius ?? BorderRadius.circular(12),
//         ),
//         child: const Center(child: Icon(Icons.image_not_supported, size: 60)),
//       );
//     }

//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         SizedBox(
//           height: height ?? 180,
//           child: PageView.builder(
//             itemCount: images.length,
//             onPageChanged: (index) => controller.currentPage.value = index,
//             itemBuilder: (context, index) {
//               return ClipRRect(
//                 borderRadius: borderRadius ?? BorderRadius.circular(12),
//                 child: Image.network(
//                   images[index],
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   errorBuilder: (context, error, stackTrace) =>
//                       Container(
//                         color: Colors.grey[300],
//                         child: const Center(child: Icon(Icons.broken_image, size: 60)),
//                       ),
//                 ),
//               );
//             },
//           ),
//         ),
//         Positioned(
//           bottom: 12,
//           child: Obx(() => Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(images.length, (index) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4),
//                 child: CircleAvatar(
//                   radius: 4,
//                   backgroundColor: controller.currentPage.value == index
//                       ? Colors.yellow
//                       : Colors.grey[400],
//                 ),
//               );
//             }),
//           )),
//         ),
//       ],
//     );
//   }
// }import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventImageSlider extends StatelessWidget {
  final List<String> images;
  final double? height;
  final BorderRadius? borderRadius;

  EventImageSlider({
    super.key,
    required this.images,
    this.height,
    this.borderRadius,
  });

  final ImageSliderController controller = Get.put(ImageSliderController());

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return Container(
        height: height ?? 180,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        child: const Center(child: Icon(Icons.image_not_supported, size: 60)),
      );
    }

    controller.pageController = PageController(
      initialPage: controller.currentPage.value,
      viewportFraction: 1.0,
    );

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: height ?? 180,
          child: PageView.builder(
            controller: controller.pageController,
            itemCount: images.length,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) => controller.currentPage.value = index,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: borderRadius ?? BorderRadius.circular(12),
                child: Image.network(
                  images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.broken_image, size: 60)),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 12,
          child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(images.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: CircleAvatar(
                  radius: 6,
                  backgroundColor: controller.currentPage.value == index
                      ? Colors.yellow[700]
                      : Colors.grey[600],
                ),
              );
            }),
          )),
        ),
      ],
    );
  }
}

class ImageSliderController extends GetxController {
  var currentPage = 0.obs;
  late PageController pageController;

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void goToPage(int page, int itemCount) {
    if (page >= 0 && page < itemCount) {
      currentPage.value = page;
      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}