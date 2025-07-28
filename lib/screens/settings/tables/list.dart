/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: list
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/settings/tables/add.dart';
import 'package:salepro/widgets/list.dart';

class TablesListScreen extends StatelessWidget {
  const TablesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListScreen(
      title: "Tables List",
      rows: [],
      columns: [],
      addPage: AddTableScreen(),
    );
  }
}
