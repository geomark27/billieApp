/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: transfers
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/transfers/add_transfer.dart';
import 'package:salepro/screens/transfers/import_transfers.dart';
import 'package:salepro/widgets/list.dart';

class TransfersScreen extends StatefulWidget {
  const TransfersScreen({super.key});

  @override
  State<TransfersScreen> createState() => _TransfersScreenState();
}

class _TransfersScreenState extends State<TransfersScreen> {
  bool requirePagination = false;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getTransfers();
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Transfers",
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
          .transfers
          .map(
            (r) => [
              r.date,
              r.referenceNo,
              r.from?.name ?? "No Warehouse Provided",
              r.to?.name ?? "No Warehouse Provided",
              r.productCost,
              r.productTax,
              r.grandTotal,
              r.status,
              r.emailSent,
            ],
          )
          .toList(),
      columns: [
        "Date",
        "Reference",
        "Warehouse (From)",
        "Warehouse (To)",
        "Product Cost",
        "Product Tax",
        "Grand Total",
        "Status",
        "Email Sent",
      ],
      addPage: AddTransferScreen(),
      importPage: ImportTransfersScreen(),
      importTooltip: "Import Transfer",
    );
  }
}
