/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class AddTableScreen extends StatefulWidget {
  const AddTableScreen({super.key});

  @override
  State<AddTableScreen> createState() => _AddTableScreenState();
}

class _AddTableScreenState extends State<AddTableScreen> {
  late TextEditingController nameController;
  late TextEditingController numberOfPersonController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    numberOfPersonController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    numberOfPersonController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Add Table",
      onSubmit: () {},
      children: [
        AppInput(
          hintText: "Name",
          placeholder: "Enter Table Name",
          controller: nameController,
        ),
        AppInput(
          hintText: "Number of Person",
          controller: numberOfPersonController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Description",
          controller: descriptionController,
          multiline: true,
        ),
      ],
    );
  }
}
