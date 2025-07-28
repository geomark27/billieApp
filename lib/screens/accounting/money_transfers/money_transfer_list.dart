/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: money_transfer_list
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/accounting/api/money_transfers.dart';
import 'package:salepro/screens/accounting/money_transfers/add_money_transfer.dart';
import 'package:salepro/screens/accounting/money_transfers/edit_money_transfer.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/widgets/list.dart';
import 'package:salepro/widgets/sortable_table.dart';

class MoneyTransferListScreen extends StatefulWidget {
  const MoneyTransferListScreen({super.key});

  @override
  State<MoneyTransferListScreen> createState() =>
      _MoneyTransferListScreenState();
}

class _MoneyTransferListScreenState extends State<MoneyTransferListScreen> {
  bool requirePagination = false;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getMoneyTransfers();
  }

  Future<void> deleteMoneyTransfer(int id, BuildContext context) async {
    Loading.start(context);
    await MoneyTransfersAPI.delete(
        id, context.read<CommonDataProvider>().token);
    // ignore: use_build_context_synchronously
    Loading.stop(context);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const MoneyTransferListScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Money Transfer List",
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
      rows: context
          .watch<CommonDataProvider>()
          .moneyTransfers
          .map(
            (mt) => [
              mt.date,
              mt.referenceNo,
              mt.fromAccount?.accountNo,
              mt.toAccount?.accountNo,
              mt.amount.toStringAsFixed(2),
            ],
          )
          .toList(),
      columns: [
        "Date",
        "Reference No",
        "From Account",
        "To Account",
        "Amount",
      ],
      addPage: AddMoneyTransferScreen(),
      tableActions: (int id) {
        return [
          TableActionIcon(
            iconType: NavLink.materialIcon,
            screen: EditMoneyTransferScreen(
              id: id,
            ),
            icon: Icons.edit,
          ),
          TableActionIcon(
            iconType: NavLink.materialIcon,
            onTap: () async {
              await deleteMoneyTransfer(
                context.read<CommonDataProvider>().accounts[id].id,
                context,
              );
            },
            icon: Icons.delete,
            lightColor: AppColors.roseSwatch.shade600,
            darkColor: AppColors.roseSwatch.shade300,
          ),
        ];
      },
      disabledIndexes: [
        context.watch<CommonDataProvider>().accounts.length,
      ],
    );
  }
}
