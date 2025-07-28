/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: import_categories
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/import_data_screen.dart';

class ImportExpenseCategoriesScreen extends StatefulWidget {
  const ImportExpenseCategoriesScreen({super.key});

  @override
  State<ImportExpenseCategoriesScreen> createState() =>
      _ImportExpenseCategoriesScreenState();
}

class _ImportExpenseCategoriesScreenState
    extends State<ImportExpenseCategoriesScreen> {
  late TextEditingController fileController;

  @override
  void initState() {
    super.initState();
    fileController = TextEditingController();
  }

  @override
  void dispose() {
    fileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ImportDataScreen(
      controller: fileController,
      title: "Import Expense Category",
      onSubmit: () {},
      prefix: const [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSpacing.kDefaultPadding * 0.5,
          ),
          child: Text(
            "The correct column order is (code*, name*) and you must follow this.",
            style: TextStyle(
              fontSize: AppSpacing.kDefaultPadding,
            ),
          ),
        ),
      ],
      fileLink: "",
    );
  }
}
