import 'package:flutter/material.dart';
import '../../constant/color.dart';
import 'custom_feild.dart';

class RegistrationForm extends StatelessWidget {
  final Function(String name, String email, String password, String confirmPassword) onRegister;
  final VoidCallback onLoginTap;

  const RegistrationForm({
    super.key,
    required this.onRegister,
    required this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    void handleRegister() {
      if (formKey.currentState?.validate() ?? false) {
        onRegister(
          nameController.text,
          emailController.text,
          passwordController.text,
          confirmPasswordController.text,
        );
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 65),
                        CustomTextField(
                          label: 'Full Name',
                          hintText: 'Enter your full name',
                          controller: nameController,
                          icon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Full Name cannot be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          label: 'Email',
                          hintText: 'Enter your Email',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          icon: Icons.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email cannot be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          label: 'Password',
                          hintText: 'Enter your password',
                          controller: passwordController,
                          obscureText: true,
                          icon: Icons.lock,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password cannot be empty';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          label: 'Confirm Password',
                          hintText: 'Re-enter your password',
                          controller: confirmPasswordController,
                          obscureText: true,
                          icon: Icons.lock,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirm Password cannot be empty';
                            }
                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: handleRegister,
                      child: Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            colors: [
                              AppColors.primary,
                              AppColors.second,
                            ]
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: AppColors.textlight,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}