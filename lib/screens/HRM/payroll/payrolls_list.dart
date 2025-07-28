/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: payrolls_list
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/HRM/payroll/add_payroll.dart';
import 'package:salepro/widgets/list.dart';

class PayrollsListScreen extends StatelessWidget {
  const PayrollsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListScreen(
      title: "Payrolls List",
      rows: [],
      columns: [],
      addPage: AddPayrollScreen(),
    );
  }
}
