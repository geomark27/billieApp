/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: employees_list
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/HRM/employees/add_employee.dart';
import 'package:salepro/widgets/list.dart';

class EmployeesListScreen extends StatelessWidget {
  const EmployeesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListScreen(
      title: "Employees List",
      rows: [],
      columns: [],
      addPage: AddEmployeeScreen(),
    );
  }
}
