/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: courier_list
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/sales/couriers/add_courier.dart';
import 'package:salepro/widgets/list.dart';

class CourierListScreen extends StatelessWidget {
  const CourierListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListScreen(
      title: "Courier List",
      rows: [],
      columns: [],
      addPage: AddCourierScreen(),
    );
  }
}
