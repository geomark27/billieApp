/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: edit_expense
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/expenses/api/expenses.dart';
import 'package:salepro/screens/expenses/expenses_list.dart';
import 'package:salepro/screens/expenses/models/expense.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/date_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';
import 'package:salepro/widgets/select.dart';

class EditExpenseScreen extends StatefulWidget {
  const EditExpenseScreen({super.key, required this.id});

  final int id;

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  late TextEditingController dateController;
  String? category;
  String? warehouse = "0";
  late TextEditingController amountController;
  String? account;
  late TextEditingController noteController;
  late Expense expense;
  Message? message;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    amountController = TextEditingController();
    noteController = TextEditingController();
    setState(() {
      expense = context.read<CommonDataProvider>().expenses[widget.id];
      dateController.text = expense.date;
      warehouse = expense.warehouse?.id.toString();
      category = expense.category?.id.toString();
      amountController.text = expense.amount;
      account = expense.account?.id.toString();
      noteController.text = expense.note ?? "";
    });
  }

  @override
  void dispose() {
    dateController.dispose();
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    Loading.start(context);
    message = await ExpensesAPI.update(
      expense.id,
      Expense(
        id: expense.id,
        date: dateController.text,
        referenceNo: '',
        amount: amountController.text,
        note: noteController.text,
        account: context.read<CommonDataProvider>().accounts[
            context.read<CommonDataProvider>().accounts.indexWhere(
                  (a) => a.id.toString() == account.toString(),
                )],
      ),
      context.read<CommonDataProvider>().token,
    );

    setState(() {});
    // ignore: use_build_context_synchronously
    Loading.stop(context);

    if (message!.success) {
      // ignore: use_build_context_synchronously
      showSnackBar(message!.message, context, type: "success");
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const ExpensesListScreen(),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(message!.message, context, type: "error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Edit Expense",
      onSubmit: handleSubmit,
      children: [
        AppDatePicker(
          hintText: "Date",
          controller: dateController,
          errorLine: message?.errors?['created_at'],
        ),
        AppSelect(
          hintText: "Expense Category",
          value: category,
          items:
              context.watch<CommonDataProvider>().selectExpenseCategoriesData,
          onChange: (value) {
            setState(() {
              category = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['expense_category_id'],
        ),
        AppSelect(
          hintText: "Warehouse",
          value: warehouse,
          items: [
            const {'label': "Select Warehouse*", 'value': "0"},
            ...context.watch<CommonDataProvider>().selectWarehousesData
          ],
          onChange: (value) {
            setState(() {
              warehouse = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['warehouse_id'],
        ),
        AppInput(
          hintText: "Amount",
          controller: amountController,
          keyboardType: TextInputType.number,
          errorLine: message?.errors?['amount'],
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
          errorLine: message?.errors?['account_id'],
        ),
        AppInput(
          hintText: "Note",
          controller: noteController,
          multiline: true,
          errorLine: message?.errors?['note'],
        ),
      ],
    );
  }
}
