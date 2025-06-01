

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zesta_1/services/firebase_control.dart';
// import 'package:zesta_1/services/profile_controller.dart';
// import 'package:zesta_1/view/widget/edit_profile.dart';

// class ProfileScreen extends StatelessWidget {
//   ProfileScreen({super.key});

//   final Rxn<Map<String, dynamic>> userData = Rxn<Map<String, dynamic>>();
//   final RxBool loading = true.obs;
//   final ProfileController profileController = ProfileController();
//   final user = FirebaseAuth.instance.currentUser;

//   void fetchProfile() async {
//     loading.value = true;
//     userData.value = await profileController.fetchProfile();
//     loading.value = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     fetchProfile();

//     return Obx(() {
//       if (loading.value) {
//         return const Scaffold(
//           body: Center(child: CircularProgressIndicator()),
//         );
//       }
//       final data = userData.value;
//       if (data == null) {
//         return const Scaffold(
//           body: Center(child: Text("No profile found.")),
//         );
//       }
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text("Profile"),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.edit),
//               onPressed: () async {
//                 final updated = await Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => EditProfileScreen(data: data)),
//                 );
//                 if (updated == true) fetchProfile();
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.logout),
//               tooltip: 'Logout',
//               onPressed: () async {
//                 await FirebaseControl().signOut();
//               },
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: ListView(
//             children: [
//               Center(
//                 child:  CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.deepPurple.shade200,
//                     child: user?.photoURL != null
//                         ? ClipOval(
//                             child: Image.network(
//                               user!.photoURL!,
//                               width: 100,
//                               height: 100,
//                               fit: BoxFit.cover,
//                             ),
//                           )
//                         : Icon(
//                             Icons.person,
//                             size: 50,
//                             color: Colors.deepPurple.shade700,
//                           ),
//                   ),
//               ),
//               const SizedBox(height: 16),
//               Center(
//                 child: Text(
//                   data['fullName'] ?? '',
//                   style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Center(
//                 child: Text(
//                   data['email'] ?? '',
//                   style: const TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               if ((data['bio'] ?? "").isNotEmpty)
//                 Center(
//                   child: Text(
//                     data['bio'],
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                 ),
//               const SizedBox(height: 16),
//               Wrap(
//                 spacing: 8,
//                 children: List<Widget>.from(
//                   (data['categories'] ?? []).map<Widget>(
//                     (cat) => Chip(label: Text(cat)),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 32),
// const Text(
//                 "About Us",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               const SizedBox(height: 18),
              
//               const Text(
//                 "Privacy Policy",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               const SizedBox(height: 18),
              
//               const Text(
//                 "Terms and Conditions",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               const SizedBox(height: 8),
              
//               const SizedBox(height: 32),
//               Center(
//                 child: Text(
//                   "Version 1.0.0", // Replace with dynamic version if needed
//                   style: TextStyle(color: Colors.grey[600]),
//                 ),
//               ),
              

//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesta_1/services/firebase_control.dart';
import 'package:zesta_1/services/profile_controller.dart';
import 'package:zesta_1/view/widget/profile/about_us.dart';
import 'package:zesta_1/view/widget/profile/edit_profile.dart';
import 'package:zesta_1/view/widget/profile/privacy_policy.dart';
import 'package:zesta_1/view/widget/profile/terms_condition.dart';

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
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.blue.shade600,
                    size: 20,
                  ),
                ),
                onPressed: () async {
                  final updated = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditProfileScreen(data: data)),
                  );
                  if (updated == true) fetchProfile();
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.logout,
                    color: Colors.red.shade600,
                    size: 20,
                  ),
                ),
                tooltip: 'Logout',
                onPressed: () async {
                  await FirebaseControl().signOut();
                },
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.grey.shade50],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView(
              children: [
                // Enhanced Profile Section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.deepPurple.shade200,
                            child: user?.photoURL != null
                                ? ClipOval(
                                    child: Image.network(
                                      user!.photoURL!,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.deepPurple.shade700,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          data['fullName'] ?? '',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            data['email'] ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      if ((data['bio'] ?? "").isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.blue.shade100),
                          ),
                          child: Text(
                            data['bio'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue.shade800,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                      if ((data['categories'] ?? []).isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: List<Widget>.from(
                            (data['categories'] ?? []).map<Widget>(
                              (cat) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade200],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  cat,
                                  style: TextStyle(
                                    color: Colors.deepPurple.shade800,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Enhanced Settings Section
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.blue.shade600,
                            size: 24,
                          ),
                        ),
                        title: const Text(
                          "About Us",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey.shade400,
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AboutUsScreen()),
                        ),
                      ),
                      Divider(height: 1, color: Colors.grey.shade200),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.privacy_tip_outlined,
                            color: Colors.green.shade600,
                            size: 24,
                          ),
                        ),
                        title: const Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey.shade400,
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => PrivacyPolicy()),
                        ),
                      ),
                      Divider(height: 1, color: Colors.grey.shade200),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.description_outlined,
                            color: Colors.orange.shade600,
                            size: 24,
                          ),
                        ),
                        title: const Text(
                          "Terms and Conditions",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey.shade400,
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) =>  TermsAndConditions()),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                Center(
                  child: Text(
                    "Version 1.0.0",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
