/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: import
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/widgets/import_data_screen.dart';

class ImportUnitsScreen extends StatefulWidget {
  const ImportUnitsScreen({super.key});

  @override
  State<ImportUnitsScreen> createState() => _ImportUnitsScreenState();
}

class _ImportUnitsScreenState extends State<ImportUnitsScreen> {
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
      title: "Import Unit",
      onSubmit: () {},
      prefix: const [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSpacing.kDefaultPadding * 0.5,
          ),
          child: Text(
            "The correct column order is (unit_code*, unit_name*, base_unit [unit code], operator, operation_value) and you must follow this.",
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
