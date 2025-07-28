/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: adjustments_list
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/products/adjustments/add_adjustment.dart';
import 'package:salepro/widgets/list.dart';

class AdjustmentsListScreen extends StatelessWidget {
  const AdjustmentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListScreen(
      title: "Adjustments List",
      rows: [],
      columns: [],
      addPage: AddAdjustmentScreen(),
    );
  }
}
