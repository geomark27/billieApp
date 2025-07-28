/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: import_data_screen
*/

import 'package:flutter/material.dart';
import 'package:salepro/widgets/drawer.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/import_data.dart';

class ImportDataScreen extends StatelessWidget {
  const ImportDataScreen({
    super.key,
    required this.title,
    required this.onSubmit,
    this.prefix,
    this.suffix,
    this.controller,
    this.fileLink,
  });

  final String title;
  final VoidCallback onSubmit;
  final List<Widget>? prefix;
  final List<Widget>? suffix;
  final TextEditingController? controller;
  final String? fileLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: const AppDrawer(),
      body: AppForm(
        onSubmit: onSubmit,
        children: [
          ImportData(
            prefix: prefix,
            suffix: suffix,
            controller: controller,
            fileLink: fileLink,
          )
        ],
      ),
    );
  }
}
