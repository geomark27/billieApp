/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class EditSMSTemplateScreen extends StatefulWidget {
  const EditSMSTemplateScreen({super.key});

  @override
  State<EditSMSTemplateScreen> createState() => _EditSMSTemplateScreenState();
}

class _EditSMSTemplateScreenState extends State<EditSMSTemplateScreen> {
  late TextEditingController nameController;
  late TextEditingController contentController;
  bool defaultSMSSale = false;
  bool defaultSMSECommerce = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Edit SMS Template",
      onSubmit: () {},
      children: [
        AppInput(
          hintText: "Name",
          controller: nameController,
        ),
        AppInput(
          hintText: "Content",
          controller: contentController,
          multiline: true,
          placeholder:
              "You can set following dynamic tags for a template: \n[reference], [customer], [sale_status], [payment_status]\nExample:\nHi [customer],\nThanks for the order. Order reference: [reference]. Order status: [sale_status]. Payment status: [payment_status].",
        ),
        AppCheckBox(
          hintText: "Default SMS Sale",
          value: defaultSMSSale,
          onChanged: (value) {
            setState(() {
              defaultSMSSale = value!;
            });
          },
        ),
        AppCheckBox(
          hintText: "Default SMS E-Commerce",
          value: defaultSMSECommerce,
          onChanged: (value) {
            setState(() {
              defaultSMSECommerce = value!;
            });
          },
        ),
      ],
    );
  }
}
