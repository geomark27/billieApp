/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: production_list
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/manufacturing/add_production.dart';
import 'package:salepro/widgets/list.dart';

class ProductionListScreen extends StatelessWidget {
  const ProductionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListScreen(
      title: "Production List",
      rows: [],
      columns: [],
      addPage: AddProductionScreen(),
    );
  }
}
