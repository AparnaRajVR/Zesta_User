
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:zesta_1/view/widget/profile/about_us.dart';
// import 'package:zesta_1/view/widget/profile/privacy_policy.dart';
// import 'package:zesta_1/view/widget/profile/terms_condition.dart';

// class ProfileSettings extends StatelessWidget {
//   final VoidCallback onEditProfile;
//   const ProfileSettings({super.key, required this.onEditProfile});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListTile(
//           leading: Icon(Icons.edit, color: Colors.green),
//           title: Text('Edit Profile'),
//           onTap: onEditProfile,
//         ),
//         Divider(),
//         ListTile(
//           leading: Icon(Icons.settings, color: Colors.blue),
//           title: Text('Account Settings'),
//           onTap: () => _showAccountSettings(context),
//         ),
//       ],
//     );
//   }

//   void _showAccountSettings(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) => AccountSettingsSheet(),
//     );
//   }
// }

// class AccountSettingsSheet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _buildSimpleTile(
//             context,
//             title: "About Us",
//             icon: Icons.info_outline,
//             color: Colors.blue,
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutUsScreen()));
//             },
//           ),
//           _divider(),
//           _buildSimpleTile(
//             context,
//             title: "Privacy Policy",
//             icon: Icons.privacy_tip_outlined,
//             color: Colors.green,
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicy()));
//             },
//           ),
//           _divider(),
//           _buildSimpleTile(
//             context,
//             title: "Terms and Conditions",
//             icon: Icons.description_outlined,
//             color: Colors.orange,
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsAndConditions()));
//             },
//           ),
//           _divider(),
//           _buildSimpleTile(
//             context,
//             title: "Logout",
//             icon: Icons.logout,
//             color: Colors.red,
//             onTap: () async {
//               await FirebaseAuth.instance.signOut();
//               Get.offAllNamed('/login');
//             },
//           ),
//           _divider(),
//           _buildSimpleTile(
//             context,
//             title: "Delete Account",
//             icon: Icons.delete_forever,
//             color: Colors.red,
//             onTap: () async {
//               final confirm = await showDialog<bool>(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: const Text('Delete Account'),
//                   content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.pop(context, false),
//                       child: const Text('Cancel'),
//                     ),
//                     TextButton(
//                       onPressed: () => Navigator.pop(context, true),
//                       child: const Text('Delete'),
//                     ),
//                   ],
//                 ),
//               );
//               if (confirm != true) return;
//               try {
//                 await FirebaseAuth.instance.currentUser?.delete();
//                 Get.offAllNamed('/login');
//               } catch (e) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Failed to delete account: $e')),
//                 );
//               }
//             },
//             isDestructive: true,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSimpleTile(BuildContext context,
//       {required String title,
//       required IconData icon,
//       required Color color,
//       required VoidCallback onTap,
//       bool isDestructive = false}) {
//     return ListTile(
//       leading: Icon(icon, color: color),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: isDestructive ? Colors.red : Colors.black,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       onTap: onTap,
//     );
//   }

//   Widget _divider() => Divider(height: 1, color: Colors.grey.shade300);
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:zesta_1/view/widget/profile/about_us.dart';
import 'package:zesta_1/view/widget/profile/privacy_policy.dart';
import 'package:zesta_1/view/widget/profile/terms_condition.dart';

class ProfileSettings extends StatelessWidget {
  final VoidCallback onEditProfile;
  const ProfileSettings({super.key, required this.onEditProfile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // Profile Actions Section
          _buildSectionCard(
            title: "Profile",
            children: [
              _buildModernTile(
                title: 'Edit Profile',
                subtitle: 'Update your personal information',
                icon: Icons.edit_outlined,
                gradient: const LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF45A049)],
                ),
                onTap: onEditProfile,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Account Settings Section
          _buildSectionCard(
            title: "Account",
            children: [
              _buildModernTile(
                title: 'Account Settings',
                subtitle: 'Privacy, security & more',
                icon: Icons.settings_outlined,
                gradient: const LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                ),
                onTap: () => _showAccountSettings(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildModernTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey.shade400,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showAccountSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AccountSettingsSheet(),
    );
  }
}

class AccountSettingsSheet extends StatelessWidget {
  const AccountSettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                const Text(
                  'Account Settings',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          
          // Settings List
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildSettingCategory(
                    title: "Information",
                    items: [
                      _buildSettingItem(
                        context,
                        title: "About Us",
                        subtitle: "Learn more about our company",
                        icon: Icons.info_outline,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3498DB), Color(0xFF2980B9)],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const AboutUsScreen()),
                          );
                        },
                      ),
                      _buildSettingItem(
                        context,
                        title: "Privacy Policy",
                        subtitle: "How we protect your data",
                        icon: Icons.privacy_tip_outlined,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF27AE60), Color(0xFF229954)],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const PrivacyPolicy()),
                          );
                        },
                      ),
                      _buildSettingItem(
                        context,
                        title: "Terms and Conditions",
                        subtitle: "Our terms of service",
                        icon: Icons.description_outlined,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF39C12), Color(0xFFE67E22)],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const TermsAndConditions()),
                          );
                        },
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  _buildSettingCategory(
                    title: "Account Actions",
                    items: [
                      _buildSettingItem(
                        context,
                        title: "Logout",
                        subtitle: "Sign out of your account",
                        icon: Icons.logout_outlined,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE74C3C), Color(0xFFC0392B)],
                        ),
                        onTap: () => _showLogoutDialog(context),
                      ),
                      _buildSettingItem(
                        context,
                        title: "Delete Account",
                        subtitle: "Permanently delete your account",
                        icon: Icons.delete_forever_outlined,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8E44AD), Color(0xFF732D91)],
                        ),
                        onTap: () => _showDeleteAccountDialog(context),
                        isDestructive: true,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCategory({required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDestructive ? const Color(0xFFE74C3C) : const Color(0xFF2C3E50),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey.shade400,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.logout, color: Color(0xFFE74C3C)),
            SizedBox(width: 12),
            Text('Logout'),
          ],
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await FirebaseAuth.instance.signOut();
              Get.offAllNamed('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE74C3C),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning, color: Color(0xFFE74C3C)),
            SizedBox(width: 12),
            Text('Delete Account'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to delete your account?'),
            SizedBox(height: 8),
            Text(
              'This action cannot be undone and will permanently remove all your data.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFE74C3C),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await FirebaseAuth.instance.currentUser?.delete();
                Get.offAllNamed('/login');
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to delete account: $e'),
                    backgroundColor: const Color(0xFFE74C3C),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE74C3C),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}