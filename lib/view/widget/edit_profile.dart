// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zesta_1/services/category_service.dart';
// import 'package:zesta_1/services/profile_controller.dart';


// class EditProfileScreen extends StatelessWidget {
//   final Map<String, dynamic> data;
//   EditProfileScreen({super.key, required this.data});

//   final _formKey = GlobalKey<FormState>();
//   final ProfileController profileController = ProfileController();

//   @override
//   Widget build(BuildContext context) {
//     final nameCtrl = TextEditingController(text: data['fullName'] ?? '');
//     final bioCtrl = TextEditingController(text: data['bio'] ?? '');
//     final RxList<String> selectedCategories = RxList<String>.from(data['categories'] ?? []);

//     return Scaffold(
//       appBar: AppBar(title: const Text("Edit Profile")),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: nameCtrl,
//                 decoration: const InputDecoration(labelText: "Full Name"),
//                 validator: (v) => v == null || v.trim().isEmpty ? "Enter name" : null,
//               ),
//               const SizedBox(height: 14),
//               TextFormField(
//                 controller: bioCtrl,
//                 decoration: const InputDecoration(labelText: "Bio"),
//                 maxLines: 2,
//               ),
//               const SizedBox(height: 18),
//               const Text("Categories", style: TextStyle(fontWeight: FontWeight.bold)),
//               // --- Dynamic Categories from Firestore ---
//               StreamBuilder<List<Map<String, dynamic>>>(
//                 stream: CategoryService().getCategories(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       child: Center(child: CircularProgressIndicator()),
//                     );
//                   }
//                   if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       child: Text("No categories found."),
//                     );
//                   }
//                   final categories = snapshot.data!;
//                   return Obx(() => Wrap(
//                         spacing: 8,
//                         children: [
//                           for (final cat in categories)
//                             FilterChip(
//                               label: Text(cat['name']),
//                               selected: selectedCategories.contains(cat['name']),
//                               onSelected: (val) {
//                                 if (val) {
//                                   selectedCategories.add(cat['name']);
//                                 } else {
//                                   selectedCategories.remove(cat['name']);
//                                 }
//                               },
//                             ),
//                         ],
//                       ));
//                 },
//               ),
//               const SizedBox(height: 28),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (!_formKey.currentState!.validate()) return;
//                   await profileController.updateProfile(
//                     fullName: nameCtrl.text.trim(),
//                     bio: bioCtrl.text.trim(),
//                     categories: selectedCategories,
//                   );
//                   Navigator.pop(context, true);
//                 },
//                 child: const Text("Save"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/services/category_service.dart';
import 'package:zesta_1/services/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  EditProfileScreen({super.key, required this.data});

  final _formKey = GlobalKey<FormState>();
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final nameCtrl = TextEditingController(text: data['fullName'] ?? '');
    final bioCtrl = TextEditingController(text: data['bio'] ?? '');
    final RxList<String> selectedCategories = RxList<String>.from(data['categories'] ?? []);
    profileController.setInitialPhotoUrl(data['photoUrl']); // Set initial image

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // --- Profile Image Section ---
              Center(
                child: Obx(() {
                  final picked = profileController.pickedImage.value;
                  final url = profileController.photoUrl.value;
                  ImageProvider imageProvider;
                  if (picked != null) {
                    imageProvider = FileImage(picked);
                  } else if (url.isNotEmpty) {
                    imageProvider = NetworkImage(url);
                  } else {
                    imageProvider = const AssetImage('assets/default_avatar.png');
                  }
                  return Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: imageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            await profileController.pickProfileImage();
                          },
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: const Icon(Icons.camera_alt, color: Colors.blue, size: 22),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              Obx(() => profileController.isUploading.value
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : const SizedBox(height: 16)),
              Obx(() => profileController.pickedImage.value != null &&
                      !profileController.isUploading.value
                  ? TextButton.icon(
                      icon: const Icon(Icons.cloud_upload),
                      label: const Text("Upload Image"),
                      onPressed: () async {
                        await profileController.uploadProfileImage();
                      },
                    )
                  : const SizedBox.shrink()),
              const SizedBox(height: 20),

              // --- Existing Form Fields ---
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (v) => v == null || v.trim().isEmpty ? "Enter name" : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: bioCtrl,
                decoration: const InputDecoration(labelText: "Bio"),
                maxLines: 2,
              ),
              const SizedBox(height: 18),
              const Text("Categories", style: TextStyle(fontWeight: FontWeight.bold)),
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: CategoryService().getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text("No categories found."),
                    );
                  }
                  final categories = snapshot.data!;
                  return Obx(() => Wrap(
                        spacing: 8,
                        children: [
                          for (final cat in categories)
                            FilterChip(
                              label: Text(cat['name']),
                              selected: selectedCategories.contains(cat['name']),
                              onSelected: (val) {
                                if (val) {
                                  selectedCategories.add(cat['name']);
                                } else {
                                  selectedCategories.remove(cat['name']);
                                }
                              },
                            ),
                        ],
                      ));
                },
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  String? photoUrl = profileController.photoUrl.value;
                  if (profileController.pickedImage.value != null &&
                      photoUrl != data['photoUrl']) {
                    photoUrl = await profileController.uploadProfileImage();
                  }
                  await profileController.updateProfile(
                    fullName: nameCtrl.text.trim(),
                    bio: bioCtrl.text.trim(),
                    categories: selectedCategories,
                    photoUrl: photoUrl,
                  );
                  Navigator.pop(context, true);
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
