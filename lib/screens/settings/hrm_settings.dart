/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: hrm_settings
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/time_picker.dart';

class HrmSettingsScreen extends StatefulWidget {
  const HrmSettingsScreen({super.key});

  @override
  State<HrmSettingsScreen> createState() => _HrmSettingsScreenState();
}

class _HrmSettingsScreenState extends State<HrmSettingsScreen> {
  late TextEditingController defaultCheckInController;
  late TextEditingController defaultCheckOutController;

  @override
  void initState() {
    super.initState();
    defaultCheckInController = TextEditingController();
    defaultCheckOutController = TextEditingController();
  }

  @override
  void dispose() {
    defaultCheckInController.dispose();
    defaultCheckOutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "HRM Setting",
      onSubmit: () {},
      children: [
        AppTimePicker(
          hintText: "Default Check In",
          controller: defaultCheckInController,
        ),
        AppTimePicker(
          hintText: "Default Check Out",
          controller: defaultCheckOutController,
        ),
      ],
    );
  }
}
