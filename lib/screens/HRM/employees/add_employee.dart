/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_employee
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  late TextEditingController nameController;
  late TextEditingController imageController;
  String? department;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController countryController;
  late TextEditingController staffIDController;
  bool addUser = true;
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  String? role = "0";

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    imageController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    countryController = TextEditingController();
    staffIDController = TextEditingController();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    imageController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    countryController.dispose();
    staffIDController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Add Employee",
      onSubmit: () {},
      children: [
        AppInput(
          hintText: "Name",
          controller: nameController,
        ),
        AppFilePicker(
          allowedExtensions: const ['jpeg', 'jpg', 'png', 'gif'],
          hintText: "Image",
          allowMultiple: false,
          controller: imageController,
        ),
        AppSelect(
          hintText: "Department",
          items: const [],
          onChange: (value) {
            setState(() {
              department = value;
            });
          },
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
        AppInput(
          hintText: "Address",
          controller: addressController,
        ),
        AppInput(
          hintText: "City",
          controller: cityController,
        ),
        AppInput(
          hintText: "Country",
          controller: countryController,
        ),
        AppInput(
          hintText: "Staff Id",
          controller: staffIDController,
        ),
        AppCheckBox(
          hintText: "Add User",
          value: addUser,
          onChanged: (value) {
            setState(() {
              addUser = value!;
            });
          },
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(),
          crossFadeState:
              addUser ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(
            milliseconds: 500,
          ),
          secondChild: Column(
            children: generateInputGroups(
              [
                AppInput(
                  hintText: "Username",
                  controller: userNameController,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
