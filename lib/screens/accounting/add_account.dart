/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: add_account
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/accounting/accounts_list.dart';
import 'package:salepro/screens/accounting/api/accounts.dart';
import 'package:salepro/screens/accounting/models/account.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/input.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({super.key});

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  late TextEditingController accountNumberController;
  late TextEditingController nameController;
  late TextEditingController initialBalanceController;
  late TextEditingController noteController;
  Message? message;

  @override
  void initState() {
    super.initState();
    accountNumberController = TextEditingController();
    nameController = TextEditingController();
    initialBalanceController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    accountNumberController.dispose();
    nameController.dispose();
    initialBalanceController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    Loading.start(context);
    message = await AccountsAPI.create(
      Account(
        id: 0,
        accountNo: accountNumberController.text,
        name: nameController.text,
        initialBalance: double.tryParse(initialBalanceController.text) ?? 0,
        note: noteController.text,
        isDefault: false,
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
          builder: (ctx) => const AccountsListScreen(),
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
      title: "Add Account",
      onSubmit: handleSubmit,
      children: [
        AppInput(
          hintText: "Account No",
          keyboardType: TextInputType.number,
          controller: accountNumberController,
          errorLine: message?.errors?['account_no'],
        ),
        AppInput(
          hintText: "Name",
          controller: nameController,
          errorLine: message?.errors?['name'],
        ),
        AppInput(
          hintText: "Initial Balance",
          keyboardType: TextInputType.number,
          controller: initialBalanceController,
          errorLine: message?.errors?['initial_balance'],
        ),
        AppInput(
          hintText: "Note",
          controller: noteController,
          errorLine: message?.errors?['note'],
        ),
      ],
    );
  }
}
