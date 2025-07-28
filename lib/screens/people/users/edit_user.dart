/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit_user
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late TextEditingController userNameController;
  late TextEditingController companyNameController;
  late TextEditingController passwordController;
  String? role = "0";
  late TextEditingController emailController;
  late TextEditingController phoneController;
  bool isActive = true;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    companyNameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    userNameController.dispose();
    companyNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Edit User",
      onSubmit: () {},
      children: [
        AppInput(
          hintText: "Username",
          controller: userNameController,
        ),
        AppInput(
          hintText: "Company Name",
          controller: companyNameController,
        ),
        AppInput(
          hintText: "Password",
          password: true,
          controller: passwordController,
        ),
        AppSelect(
          hintText: "Role",
          value: role,
          onChange: (String? value) {
            setState(() {
              role = value;
            });
          },
          items: [
            const {'label': "Select Role*", 'value': "0"},
            ...context.watch<CommonDataProvider>().selectRolesData
          ],
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Email",
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
        ),
        AppInput(
          hintText: "Phone Number",
          keyboardType: TextInputType.phone,
          controller: phoneController,
        ),
        AppCheckBox(
          hintText: "Active",
          value: isActive,
          onChanged: (value) {
            setState(() {
              isActive = value!;
            });
          },
        ),
      ],
    );
  }
}
