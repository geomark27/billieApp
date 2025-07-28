/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: list
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/settings/sms_templates/add.dart';
import 'package:salepro/widgets/list.dart';

class SMSListScreen extends StatelessWidget {
  const SMSListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListScreen(
      title: "SMS Templates List",
      rows: [],
      columns: [],
      addPage: AddSMSTemplateScreen(),
    );
  }
}
