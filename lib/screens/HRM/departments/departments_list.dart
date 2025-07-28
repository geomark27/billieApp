/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: departments_list
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/HRM/departments/add_department.dart';
import 'package:salepro/widgets/list.dart';

class DepartmentsListScreen extends StatelessWidget {
  const DepartmentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListScreen(
      title: "Departments List",
      rows: [],
      columns: [],
      addPage: AddDepartmentScreen(),
    );
  }
}
