/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_attendance
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/date_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';
import 'package:salepro/widgets/time_picker.dart';

class AddAttendanceScreen extends StatefulWidget {
  const AddAttendanceScreen({super.key});

  @override
  State<AddAttendanceScreen> createState() => _AddAttendanceScreenState();
}

class _AddAttendanceScreenState extends State<AddAttendanceScreen> {
  String? employee;
  late TextEditingController dateController;
  late TextEditingController checkInController;
  late TextEditingController checkOutController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    checkInController = TextEditingController();
    checkOutController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    dateController.dispose();
    checkInController.dispose();
    checkOutController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Add Attendance",
      onSubmit: () {},
      children: [
        AppSelect(
          hintText: "Employee",
          items: const [],
          value: employee,
          onChange: (value) {
            setState(() {
              employee = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppDatePicker(
          hintText: "Date",
          controller: dateController,
        ),
        AppTimePicker(
          hintText: "Check In",
          controller: checkInController,
        ),
        AppTimePicker(
          hintText: "Check Out",
          controller: checkOutController,
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
