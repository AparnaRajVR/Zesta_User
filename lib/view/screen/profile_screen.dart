

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/services/firebase_control.dart';
import 'package:zesta_1/services/profile_controller.dart';
import 'package:zesta_1/view/widget/edit_profile.dart';

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
        appBar: AppBar(
          title: const Text("Profile"),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final updated = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditProfileScreen(data: data)),
                );
                if (updated == true) fetchProfile();
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () async {
                await FirebaseControl().signOut();
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              Center(
                child:  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.deepPurple.shade200,
                    child: user?.photoURL != null
                        ? ClipOval(
                            child: Image.network(
                              user!.photoURL!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.deepPurple.shade700,
                          ),
                  ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  data['fullName'] ?? '',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  data['email'] ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),
              if ((data['bio'] ?? "").isNotEmpty)
                Center(
                  child: Text(
                    data['bio'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: List<Widget>.from(
                  (data['categories'] ?? []).map<Widget>(
                    (cat) => Chip(label: Text(cat)),
                  ),
                ),
              ),
              const SizedBox(height: 32),
const Text(
                "About Us",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 18),
              
              const Text(
                "Privacy Policy",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 18),
              
              const Text(
                "Terms and Conditions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              
              const SizedBox(height: 32),
              Center(
                child: Text(
                  "Version 1.0.0", // Replace with dynamic version if needed
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              

            ],
          ),
        ),
      );
    });
  }
}
