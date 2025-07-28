/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class AddLanguageScreen extends StatefulWidget {
  const AddLanguageScreen({super.key});

  @override
  State<AddLanguageScreen> createState() => _AddLanguageScreenState();
}

class _AddLanguageScreenState extends State<AddLanguageScreen> {
  late TextEditingController nameController;
  late TextEditingController shortKeyController;

  @override
  void initState() {
    nameController = TextEditingController();
    shortKeyController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    shortKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Add Language",
      onSubmit: () {},
      children: [
        AppInput(
          hintText: "New Language Name",
          controller: nameController,
        ),
        AppInput(
          hintText: "New Language Short Key",
          controller: shortKeyController,
          placeholder: "example: 'en', 'es' etc.",
        ),
      ],
    );
  }
}
