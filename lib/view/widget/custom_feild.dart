
import 'package:flutter/material.dart';

import '../../constant/color.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? icon;
  final String? Function(String?)? validator; 

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.icon,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
       autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.textdark,
        ),
        hintText: hintText,
        suffixIcon: Icon(icon, color: AppColors.textaddn),
      ),
    );
  }
}


