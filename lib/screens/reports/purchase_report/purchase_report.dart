/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: purchase_report
*/

import 'package:flutter/material.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/reports/purchase_report/models/purchase_report.dart';
import 'package:salepro/screens/reports/purchase_report/utils/fetch_purchase_report.dart';
import 'package:salepro/widgets/list.dart';

class PurchaseReportScreen extends StatefulWidget {
  const PurchaseReportScreen(
      {super.key,
      required this.report,
      required this.start,
      required this.end,
      required this.warehouse});

  final Data<PurchaseReport> report;
  final DateTime start;
  final DateTime end;
  final String warehouse;

  @override
  State<PurchaseReportScreen> createState() => _PurchaseReportScreenState();
}

class _PurchaseReportScreenState extends State<PurchaseReportScreen> {
  List<PurchaseReport> purchaseReports = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      purchaseReports = widget.report.data;
    });
  }

  Future<void> fetchData(BuildContext context, {int count = 1}) async {
    final report = await fetchPurchaseReport(
      context,
      widget.start,
      widget.end,
      widget.warehouse,
      count: count,
    );

    setState(() {
      if (count == 1) {
        purchaseReports = report.data;
      } else {
        purchaseReports = [
          ...purchaseReports,
          ...report.data,
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Purchase Report",
      requirePagination: widget.report.requirePagination,
      fetchMethod: () async {
        await fetchData(context);
      },
      onRefresh: () async {
        await fetchData(context);
      },
      loadNewPage: (count) async {
        await fetchData(
          context,
          count: count,
        );
      },
      rows: purchaseReports
          .map(
            (r) => [
              r.name,
              r.category,
              r.purchasedAmount,
              r.purchasedQty,
              r.inStock,
            ],
          )
          .toList(),
      columns: [
        "Product",
        "Category",
        "Purchased Amount",
        "Purchased Qty",
        "In Stock",
      ],
    );
  }
}
