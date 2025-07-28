/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: send
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/date_picker.dart';
import 'package:salepro/widgets/file_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({super.key});

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  String? user;
  late TextEditingController reminderDateController;
  late TextEditingController documentController;
  late TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    reminderDateController = TextEditingController();
    documentController = TextEditingController();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    reminderDateController.dispose();
    documentController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Send Notification",
      onSubmit: () {},
      children: [
        AppSelect(
          hintText: "Select User",
          value: user,
          items: const [],
          onChange: (value) {
            setState(() {
              user = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppDatePicker(
          hintText: "Reminder Date",
          controller: reminderDateController,
        ),
        AppFilePicker(
          hintText: "Attach Document",
          allowMultiple: false,
          controller: documentController,
        ),
        AppInput(
          hintText: "Message",
          controller: messageController,
          multiline: true,
        ),
      ],
    );
  }
}
