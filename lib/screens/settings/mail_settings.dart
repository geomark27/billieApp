/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: mail_settings
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class MailSettingsScreen extends StatefulWidget {
  const MailSettingsScreen({super.key});

  @override
  State<MailSettingsScreen> createState() => _MailSettingsScreenState();
}

class _MailSettingsScreenState extends State<MailSettingsScreen> {
  late TextEditingController mailDriverController;
  late TextEditingController mailHostController;
  late TextEditingController mailPortController;
  late TextEditingController mailAddressController;
  late TextEditingController mailFromNameController;
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late TextEditingController encryptionController;

  @override
  void initState() {
    super.initState();
    mailDriverController = TextEditingController();
    mailHostController = TextEditingController();
    mailPortController = TextEditingController();
    mailAddressController = TextEditingController();
    mailFromNameController = TextEditingController();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    encryptionController = TextEditingController();
  }

  @override
  void dispose() {
    mailDriverController.dispose();
    mailHostController.dispose();
    mailPortController.dispose();
    mailAddressController.dispose();
    mailFromNameController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    encryptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Mail Settings",
      onSubmit: () {},
      children: [
        AppInput(
          hintText: "Mail Driver",
          controller: mailDriverController,
        ),
        AppInput(
          hintText: "Mail Host",
          controller: mailHostController,
        ),
        AppInput(
          hintText: "Mail Port",
          controller: mailPortController,
          keyboardType: TextInputType.number,
        ),
        AppInput(
          hintText: "Mail Address",
          controller: mailAddressController,
        ),
        AppInput(
          hintText: "Mail From Name",
          controller: mailFromNameController,
        ),
        AppInput(
          hintText: "Username",
          controller: userNameController,
        ),
        AppInput(
          hintText: "Password",
          controller: passwordController,
          password: true,
        ),
        AppInput(
          hintText: "Encryption",
          controller: encryptionController,
        ),
      ],
    );
  }
}
