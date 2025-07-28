/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class EditLanguageScreen extends StatefulWidget {
  const EditLanguageScreen({super.key});

  @override
  State<EditLanguageScreen> createState() => _AddLanguageScreenState();
}

class _AddLanguageScreenState extends State<EditLanguageScreen> {
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
      title: "Edit Language",
      onSubmit: () {},
      children: [
        AppInput(
          hintText: "Language Name",
          controller: nameController,
        ),
        AppInput(
          hintText: "Language Short Key",
          controller: shortKeyController,
          placeholder: "example: 'en', 'es' etc.",
        ),
      ],
    );
  }
}
