/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit_payroll
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/date_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class EditPayrollScreen extends StatefulWidget {
  const EditPayrollScreen({super.key});

  @override
  State<EditPayrollScreen> createState() => _EditPayrollScreenState();
}

class _EditPayrollScreenState extends State<EditPayrollScreen> {
  late TextEditingController dateController;
  String? employee;
  String? account;
  late TextEditingController amountController;
  String? method = "cash";
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    amountController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    dateController.dispose();
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Edit Payroll",
      onSubmit: () {},
      children: [
        AppDatePicker(
          hintText: "Date",
          controller: dateController,
        ),
        AppSelect(
          hintText: "Employee",
          items: const [],
          value: employee,
          onChange: (value) {
            setState(() {
              employee = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppSelect(
          hintText: "Account",
          value: account,
          items: context.watch<CommonDataProvider>().selectAccountsData,
          onChange: (value) {
            setState(() {
              account = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Amount",
          controller: amountController,
          keyboardType: TextInputType.number,
        ),
        AppSelect(
          hintText: "Method",
          value: method,
          items: const [
            {"label": "Cash", "value": "cash"},
            {"label": "Cheque", "value": "cheque"},
            {"label": "Credit Card", "value": "credit_card"},
          ],
          onChange: (value) {
            setState(() {
              method = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
        ),
        AppInput(
          hintText: "Note",
          controller: noteController,
          multiline: true,
        ),
      ],
    );
  }
}
