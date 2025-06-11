
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/services/firebase_control.dart';
import 'package:zesta_1/services/profile_controller.dart';
import 'package:zesta_1/view/widget/profile/edit_profile.dart';
import 'package:zesta_1/view/widget/profile/profile_header.dart';
import 'package:zesta_1/view/widget/profile/profile_setting.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final Rxn<Map<String, dynamic>> userData = Rxn<Map<String, dynamic>>();
  final RxBool loading = true.obs;
  final ProfileController profileController = ProfileController();
  final user = FirebaseAuth.instance.currentUser;

  void fetchProfile() async {
    loading.value = true;
    userData.value = await profileController.fetchProfile();
    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    fetchProfile();

    return Obx(() {
      if (loading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final data = userData.value;
      if (data == null) {
        return const Scaffold(
          body: Center(child: Text("No profile found.")),
        );
      }

      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          title: const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.w600,),
            
          ),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.edit, color: Colors.blue.shade600),
          //     onPressed: () async {
          //       final updated =
          //           await Get.to(() => EditProfileScreen(data: data));
          //       if (updated == true) fetchProfile();
          //     },
          //   ),
          //   IconButton(
          //     icon: Icon(Icons.logout, color: Colors.red.shade600),
          //     onPressed: () async {
          //       await FirebaseControl().signOut();
          //     },
          //   ),
          // ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            ProfileHeader(data: data, user: user),
            const SizedBox(height: 32),
             ProfileSettings(onEditProfile: () { 
              Get.to(EditProfileScreen(data: data,));
             },),
            const SizedBox(height: 32),
            Center(
              child: Text(
                "Version 1.0.0",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ),
          ],
        ),
      );
    });
  }
}
