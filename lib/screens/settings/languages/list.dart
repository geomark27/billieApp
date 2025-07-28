/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: list
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/settings/languages/add.dart';
import 'package:salepro/widgets/list.dart';

class LanguagesListScreen extends StatelessWidget {
  const LanguagesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListScreen(
      title: "Languages List",
      rows: [],
      columns: [],
      addPage: AddLanguageScreen(),
    );
  }
}
