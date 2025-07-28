/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: create_sms
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class CreateSmsScreen extends StatefulWidget {
  const CreateSmsScreen({super.key});

  @override
  State<CreateSmsScreen> createState() => _CreateSmsScreenState();
}

class _CreateSmsScreenState extends State<CreateSmsScreen> {
  String? template;
  late TextEditingController customerDetailsController;
  late TextEditingController mobileController;
  late TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    customerDetailsController = TextEditingController();
    mobileController = TextEditingController();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    customerDetailsController.dispose();
    mobileController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Create SMS",
      onSubmit: () {},
      children: [
        AppSelect(
          hintText: "SMS Template",
          items: const [],
          value: template,
          onChange: (value) {
            setState(() {
              template = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Customer Detail",
          placeholder: "Please enter customer name or mobile no and select...",
          controller: customerDetailsController,
        ),
        AppInput(
          hintText: "Mobile",
          placeholder: "example: +8801*********, +8801*********",
          controller: mobileController,
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
