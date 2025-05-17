import 'package:flutter/material.dart';
import 'package:zesta_1/constant/color.dart';

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: isActive ? 20 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.textaddn,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
