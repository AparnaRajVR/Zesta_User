// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ProfileHeader extends StatelessWidget {
//   final Map<String, dynamic> data;
//   final User? user;

//   const ProfileHeader({super.key, required this.data, required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Center(
//             child: CircleAvatar(
//               radius: 60,
//               backgroundColor: Colors.deepPurple.shade200,
//               backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
//               child: user?.photoURL == null
//                   ? Icon(Icons.person, size: 60, color: Colors.deepPurple.shade700)
//                   : null,
//             ),
//           ),
//           const SizedBox(height: 20),
//           Text(
//             data['fullName'] ?? '',
//             style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               data['email'] ?? '',
//               style: TextStyle(fontSize: 16, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
//             ),
//           ),
//           if ((data['bio'] ?? "").isNotEmpty) ...[
//             const SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade50,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.blue.shade100),
//               ),
//               child: Text(
//                 data['bio'],
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.blue.shade800, fontSize: 16, height: 1.4),
//               ),
//             ),
//           ],
//           if ((data['categories'] ?? []).isNotEmpty) ...[
//             const SizedBox(height: 20),
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: List<Widget>.from(
//                 (data['categories'] as List).map(
//                   (cat) => Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade200],
//                       ),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       cat,
//                       style: TextStyle(color: Colors.deepPurple.shade800, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zesta_1/constant/color.dart';

class ProfileHeader extends StatelessWidget {
  final Map<String, dynamic> data;
  final User? user;

  const ProfileHeader({super.key, required this.data, required this.user});



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Clean header section
          Container(
            padding: const EdgeInsets.only(top: 32, bottom: 16),
            child: Column(
              children: [
                // Profile Avatar with elegant styling
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:AppColors.primary.withOpacity(0.2),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
                    child: user?.photoURL == null
                        ? Icon(
                            Icons.person,
                            size: 45,
                            color: AppColors.primary,
                          )
                        : null,
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Name with elegant typography
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    data['fullName'] ?? 'User Name',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.second,
                      height: 1.2,
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Email with clean styling
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon(
                      //   Icons.email_outlined,
                      //   size: 16,
                      //   color: Colors.grey.shade600,
                      // ),
                      // const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          data['email'] ?? user?.email ?? 'No email',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Bio section with clean design
          if ((data['bio'] ?? "").isNotEmpty) ...[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'About',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.second,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    data['bio'],
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 15,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
          
          // Categories with clean chip design
          if ((data['categories'] ?? []).isNotEmpty) ...[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.second,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.category_outlined,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Interests',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.second,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _buildCategoryChips(data['categories'] as List),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
          
          // Add some bottom padding if no categories
          if ((data['categories'] ?? []).isEmpty) const SizedBox(height: 24),
        ],
      ),
    );
  }

  List<Widget> _buildCategoryChips(List categories) {
    return categories.map((category) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          category.toString(),
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      );
    }).toList();
  }
}