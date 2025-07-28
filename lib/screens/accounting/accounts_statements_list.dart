/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: accounts_statements_list
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/accounting/models/account.dart';
import 'package:salepro/screens/accounting/models/account_statement.dart';
import 'package:salepro/widgets/list.dart';

class AccountsStatementsListScreen extends StatefulWidget {
  const AccountsStatementsListScreen({
    super.key,
    required this.account,
    required this.transactions,
  });

  final Account account;
  final List<AccountStatement> transactions;

  @override
  State<AccountsStatementsListScreen> createState() =>
      _AccountsStatementsListScreenState();
}

class _AccountsStatementsListScreenState
    extends State<AccountsStatementsListScreen> {
  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: widget.account.name,
      requirePagination: false,
      rows: widget.transactions
          .map(
            (t) => [
              t.date,
              t.referenceNo,
              t.relatedTransaction,
              t.credit,
              t.debit,
              t.balance,
            ],
          )
          .toList(),
      columns: [
        "Date",
        "Reference No",
        "Related Transaction",
        "Credit",
        "Debit",
        "Balance",
      ],
    );
  }
}
