/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_holiday
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/date_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class AddHolidayScreen extends StatefulWidget {
  const AddHolidayScreen({super.key});

  @override
  State<AddHolidayScreen> createState() => _AddHolidayScreenState();
}

class _AddHolidayScreenState extends State<AddHolidayScreen> {
  late TextEditingController fromController;
  late TextEditingController toController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    fromController = TextEditingController();
    toController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Add Holiday",
      onSubmit: () {},
      children: [
        AppDatePicker(
          hintText: "From",
          controller: fromController,
        ),
        AppDatePicker(
          hintText: "To",
          controller: toController,
        ),
        AppInput(
          hintText: "Note",
          controller: noteController,
          multiline: true,
        ),
      ],
    );
  }
}
