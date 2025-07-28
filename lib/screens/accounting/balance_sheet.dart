/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: balance_sheet
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/widgets/list.dart';

class BalanceSheetScreen extends StatefulWidget {
  const BalanceSheetScreen({super.key});

  @override
  State<BalanceSheetScreen> createState() => _BalanceSheetsScrenState();
}

class _BalanceSheetsScrenState extends State<BalanceSheetScreen> {
  bool requirePagination = false;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().balanceSheets();
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Balance Sheet",
      requirePagination: requirePagination,
      fetchMethod: () async {
        Data data = await fetchData(context);
        setState(() {
          requirePagination = data.requirePagination;
        });
      },
      onRefresh: () async {
        Data data = await fetchData(context);
        setState(() {
          requirePagination = data.requirePagination;
        });
      },
      rows: [
        ...context.watch<CommonDataProvider>().balancesheets.map(
              (balancesheet) => [
                balancesheet.account?.name,
                balancesheet.account?.accountNo,
                balancesheet.credit.toStringAsFixed(2),
                balancesheet.debit.toStringAsFixed(2),
                balancesheet.balance.toStringAsFixed(2),
              ],
            ),
        [
          {
            "type": "custom",
            "child": Text(
              "Total",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppSpacing.kDefaultPadding * 1.2,
              ),
            )
          },
          {
            "type": "blank",
          },
          {
            "type": "custom",
            "child": Text(
              context
                  .watch<CommonDataProvider>()
                  .balancesheets
                  .fold(
                    0.00,
                    (total, bs) => total += bs.credit,
                  )
                  .toStringAsFixed(2),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppSpacing.kDefaultPadding * 1.2,
              ),
            )
          },
          {
            "type": "custom",
            "child": Text(
              context
                  .watch<CommonDataProvider>()
                  .balancesheets
                  .fold(
                    0.00,
                    (total, bs) => total += bs.debit,
                  )
                  .toStringAsFixed(2),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppSpacing.kDefaultPadding * 1.2,
              ),
            )
          },
          {
            "type": "custom",
            "child": Text(
              context
                  .watch<CommonDataProvider>()
                  .balancesheets
                  .fold(
                    0.00,
                    (total, bs) => total += bs.balance,
                  )
                  .toStringAsFixed(2),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppSpacing.kDefaultPadding * 1.2,
              ),
            )
          },
        ]
      ],
      columns: [
        "Name",
        "Account No",
        "Credit",
        "Debit",
        "Balance",
      ],
    );
  }
}
