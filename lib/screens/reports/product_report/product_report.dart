/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: product_report
*/

import 'package:flutter/material.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/reports/product_report/models/product_report.dart';
import 'package:salepro/screens/reports/product_report/utils/fetch_product_report.dart';
import 'package:salepro/widgets/list.dart';

class ProductReportScreen extends StatefulWidget {
  const ProductReportScreen(
      {super.key,
      required this.report,
      required this.start,
      required this.end,
      required this.warehouse});

  final Data<ProductReport> report;
  final DateTime start;
  final DateTime end;
  final String warehouse;

  @override
  State<ProductReportScreen> createState() => _ProductReportScreenState();
}

class _ProductReportScreenState extends State<ProductReportScreen> {
  List<ProductReport> productReports = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      productReports = widget.report.data;
    });
  }

  Future<void> fetchData(BuildContext context, {int count = 1}) async {
    final report = await fetchProductReport(
      context,
      widget.start,
      widget.end,
      widget.warehouse,
      count: count,
    );

    setState(() {
      if (count == 1) {
        productReports = report.data;
      } else {
        productReports = [
          ...productReports,
          ...report.data,
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Product Report",
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
      rows: productReports
          .map(
            (r) => [
              r.name,
              r.category,
              r.purchasedAmount,
              r.purchasedQty,
              r.soldAmount,
              r.soldQty,
              r.returnedAmount,
              r.returnedQty,
              r.purchaseReturnedAmount,
              r.purchaseReturnedQty,
              r.profit,
              r.inStock,
              r.stockWorth,
            ],
          )
          .toList(),
      columns: [
        "Product",
        "Category",
        "Purchased Amount",
        "Purchased Qty",
        "Sold Amount",
        "Sold Qty",
        "Returned Amount",
        "Returned Qty",
        "Purchase Returned Amount",
        "Purchase Returned Qty",
        "Profit",
        "In Stock",
        "Stock Worth (Price/Cost)",
      ],
    );
  }
}
