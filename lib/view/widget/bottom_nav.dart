import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:zesta_1/constant/color.dart';

class BottomNavWidget extends StatelessWidget {
  final RxInt selectedIndex;
  final Function(int) onTabChange;

  const BottomNavWidget({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.textlight,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Obx(() => GNav(
            backgroundColor: AppColors.textlight,
            rippleColor: AppColors.primary.withOpacity(0.2),
            hoverColor: AppColors.primary.withOpacity(0.1),
            gap: 8,
            activeColor: AppColors.primary,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: AppColors.primary.withOpacity(0.1),
            color: AppColors.textaddn,
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.event, text: 'Tickets'),
              GButton(icon: Icons.analytics, text: 'Analytics'),
              GButton(icon: Icons.person, text: 'Profile'),
            ],
            selectedIndex: selectedIndex.value,
            onTabChange: onTabChange,
          )),
    );
  }
}