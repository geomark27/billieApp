/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: update_profile
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController companyController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    companyController = TextEditingController();
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Update Profile",
      onSubmit: () {},
      children: [
        AppInput(
          hintText: "Username",
          controller: userNameController,
        ),
        AppInput(
          hintText: "Email Address",
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        AppInput(
          hintText: "Phone Number",
          controller: phoneController,
          keyboardType: TextInputType.phone,
        ),
        AppInput(
          hintText: "Company Name",
          controller: companyController,
        ),
      ],
    );
  }
}
