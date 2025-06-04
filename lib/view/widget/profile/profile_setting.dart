import 'package:flutter/material.dart';
import 'package:zesta_1/constant/color.dart';
import 'package:zesta_1/view/widget/profile/about_us.dart';
import 'package:zesta_1/view/widget/profile/privacy_policy.dart';
import 'package:zesta_1/view/widget/profile/terms_condition.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.textlight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.textdark,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTile(
            context,
            title: "About Us",
            icon: Icons.info_outline,
            color: Colors.blue,
            destination: const AboutUsScreen(),
          ),
          _divider(),
          _buildTile(
            context,
            title: "Privacy Policy",
            icon: Icons.privacy_tip_outlined,
            color: Colors.green,
            destination: const PrivacyPolicy(),
          ),
          _divider(),
          _buildTile(
            context,
            title: "Terms and Conditions",
            icon: Icons.description_outlined,
            color: Colors.orange,
            destination: const TermsAndConditions(),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required Widget destination,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black87),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
      },
    );
  }

  Widget _divider() => Divider(height: 1, color: Colors.grey.shade200);
}
