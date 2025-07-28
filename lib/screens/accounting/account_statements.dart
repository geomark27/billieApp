/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: account_statements
*/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/accounting/accounts_statements_list.dart';
import 'package:salepro/screens/accounting/api/account_statements.dart';
import 'package:salepro/screens/accounting/models/account.dart';
import 'package:salepro/screens/accounting/models/account_statement.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/create_model_from_map.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/date_range_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/select.dart';

class AccountStatementsScreen extends StatefulWidget {
  const AccountStatementsScreen({super.key});

  @override
  State<AccountStatementsScreen> createState() =>
      _AccountStatementsScreenState();
}

class _AccountStatementsScreenState extends State<AccountStatementsScreen> {
  String? account;
  String? type;
  late TextEditingController dateController;
  DateTime? start;
  DateTime? end;
  Message? message;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    if (start == null || end == null) return;
    Loading.start(context);
    final Account selectedAccount = context.read<CommonDataProvider>().accounts[
        context.read<CommonDataProvider>().accounts.indexWhere(
              (a) => a.id.toString() == account,
            )];
    message = await AccountStatementsAPI.create(
      AccountStatement(
        account: selectedAccount,
        type: type,
        startDate: DateFormat('yyyy-MM-dd').format(start!),
        endDate: DateFormat('yyyy-MM-dd').format(end!),
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
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => AccountsStatementsListScreen(
            account: selectedAccount,
            transactions: createModelFromMap<AccountStatement>(
              message?.data,
              (Map<String, dynamic> json) => AccountStatement.fromJson(json),
            ),
          ),
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
      title: "Account Statement",
      onSubmit: handleSubmit,
      children: [
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
        AppSelect(
          hintText: "Type",
          value: type,
          items: context.watch<CommonDataProvider>().accountTypes,
          onChange: (value) {
            setState(() {
              type = value;
            });
          },
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['type'],
        ),
        AppDateRangePicker(
          hintText: "Choose Your Date",
          controller: dateController,
          onChanged: (s, e) {
            setState(() {
              start = s;
              end = e;
            });
          },
          errorLine: [
            if (message?.errors?['start_date'] != null)
              ...message?.errors?['start_date'],
            if (message?.errors?['end_date'] != null)
              ...message?.errors?['end_date'],
          ],
        ),
      ],
    );
  }
}
