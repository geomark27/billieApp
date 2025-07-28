/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: supplier_due_report
*/

import 'package:flutter/material.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/reports/supplier_due_report/models/supplier_due_report.dart';
import 'package:salepro/screens/reports/supplier_due_report/utils/fetch_supplier_due_report.dart';
import 'package:salepro/widgets/list.dart';

class SupplierDueReportScreen extends StatefulWidget {
  const SupplierDueReportScreen(
      {super.key,
      required this.report,
      required this.start,
      required this.end});

  final Data<SupplierDueReport> report;
  final DateTime start;
  final DateTime end;

  @override
  State<SupplierDueReportScreen> createState() =>
      _SupplierDueReportScreenState();
}

class _SupplierDueReportScreenState extends State<SupplierDueReportScreen> {
  List<SupplierDueReport> dueReports = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      dueReports = widget.report.data;
    });
  }

  Future<void> fetchData(BuildContext context, {int count = 1}) async {
    final report = await fetchSupplierDueReport(
      context,
      widget.start,
      widget.end,
      count: count,
    );

    setState(() {
      if (count == 1) {
        dueReports = report.data;
      } else {
        dueReports = [
          ...dueReports,
          ...report.data,
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Customer Due Report",
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
      rows: dueReports
          .map(
            (r) => [
              r.date,
              r.reference,
              r.supplier,
              r.grandTotal,
              r.returnedAmount,
              r.paid,
              r.due,
            ],
          )
          .toList(),
      columns: [
        "Date",
        "Reference",
        "Supplier Details",
        "Grand Total",
        "Returned Amount",
        "Paid",
        "Due",
      ],
    );
  }
}
