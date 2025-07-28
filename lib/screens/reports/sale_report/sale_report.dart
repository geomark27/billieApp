/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: sale_report
*/

import 'package:flutter/material.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/reports/sale_report/models/sale_report.dart';
import 'package:salepro/screens/reports/sale_report/utils/fetch_sale_report.dart';
import 'package:salepro/widgets/list.dart';

class SaleReportScreen extends StatefulWidget {
  const SaleReportScreen(
      {super.key,
      required this.report,
      required this.start,
      required this.end,
      required this.warehouse});

  final Data<SaleReport> report;
  final DateTime start;
  final DateTime end;
  final String warehouse;

  @override
  State<SaleReportScreen> createState() => _SaleReportScreenState();
}

class _SaleReportScreenState extends State<SaleReportScreen> {
  List<SaleReport> saleReports = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      saleReports = widget.report.data;
    });
  }

  Future<void> fetchData(BuildContext context, {int count = 1}) async {
    final report = await fetchSaleReport(
      context,
      widget.start,
      widget.end,
      widget.warehouse,
      count: count,
    );

    setState(() {
      if (count == 1) {
        saleReports = report.data;
      } else {
        saleReports = [
          ...saleReports,
          ...report.data,
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Sale Report",
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
      rows: saleReports
          .map(
            (r) => [
              r.name,
              r.category,
              r.soldAmount,
              r.soldQty,
              r.inStock,
            ],
          )
          .toList(),
      columns: [
        "Product",
        "Category",
        "Sold Amount",
        "Sold Qty",
        "In Stock",
      ],
    );
  }
}
