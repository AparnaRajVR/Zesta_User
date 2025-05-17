import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zesta_1/services/firebase_control.dart';

class ProfileScreen extends StatelessWidget {
  final FirebaseControl _firebaseControl = Get.find<FirebaseControl>();

   ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.logout),
        //     onPressed: () {
        //       _firebaseControl.signOut();
        //     },
        //   ),
        // ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading profile"));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("No profile data found"));
          }
          
         
          Map<String, dynamic> userData = 
              snapshot.data!.data() as Map<String, dynamic>;
          
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  userData['fullName'] ?? 'Zesta User',
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  userData['email'] ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 40),
                // _buildProfileCard(
                //   title: 'Account Information',
                //   children: [
                //     _buildInfoRow('Role', userData['role'] ?? 'zestauser'),
                //     _buildInfoRow('User ID', userData['uid'] ?? ''),
                //   ],
                // ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _firebaseControl.signOut();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: Text(
                    'Logout', 
                    style: TextStyle(fontSize: 16, color: Colors.white)
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<DocumentSnapshot> _getUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('No user logged in.');
    }
    
    return FirebaseFirestore.instance
        .collection('zesta_user')
        .doc(currentUser.uid)
        .get();
  }

  // Widget _buildProfileCard({required String title, required List<Widget> children}) {
  //   return Card(
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             title,
  //             style: TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           SizedBox(height: 12),
  //           ...children,
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}