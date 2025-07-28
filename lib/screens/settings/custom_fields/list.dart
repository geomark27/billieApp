/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: list
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/settings/custom_fields/add.dart';
import 'package:salepro/widgets/list.dart';

class CustomFieldListScreen extends StatelessWidget {
  const CustomFieldListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListScreen(
      title: "Custom Fields",
      rows: [],
      columns: [],
      addPage: AddCustomFieldScreen(),
    );
  }
}
