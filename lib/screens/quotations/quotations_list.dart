/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: quotations_list
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/quotations/add_quotation.dart';
import 'package:salepro/widgets/list.dart';

class QuotationsListScreen extends StatefulWidget {
  const QuotationsListScreen({super.key});

  @override
  State<QuotationsListScreen> createState() => _QuotationsListScreenState();
}

class _QuotationsListScreenState extends State<QuotationsListScreen> {
  bool requirePagination = false;

  Future<Data> fetchData(BuildContext context) async {
    return await context.read<CommonDataProvider>().getQuotations();
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Quotations List",
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
          .quotations
          .map(
            (r) => [
              r.date,
              r.referenceNo,
              r.warehouse?.name ?? "No Warehouse Provided",
              r.biller?.name ?? "No Biller Provided",
              r.customer?.name ?? "No Customer Provided",
              r.supplier?.name ?? "No Supplier Provided",
              r.status,
              r.grandTotal,
            ],
          )
          .toList(),
      columns: [
        "Date",
        "Reference",
        "Warehouse",
        "Biller",
        "Customer",
        "Supplier",
        "Quotation Status",
        "Grand Total",
      ],
      addPage: AddQuotationScreen(),
    );
  }
}
