/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_due_report
*/

import 'package:flutter/material.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/reports/customer_due_report/models/customer_due_report.dart';
import 'package:salepro/screens/reports/customer_due_report/utils/fetch_customer_due_report.dart';
import 'package:salepro/widgets/list.dart';

class CustomerDueReportScreen extends StatefulWidget {
  const CustomerDueReportScreen(
      {super.key,
      required this.report,
      required this.start,
      required this.end});

  final Data<CustomerDueReport> report;
  final DateTime start;
  final DateTime end;

  @override
  State<CustomerDueReportScreen> createState() =>
      _CustomerDueReportScreenState();
}

class _CustomerDueReportScreenState extends State<CustomerDueReportScreen> {
  List<CustomerDueReport> dueReports = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      dueReports = widget.report.data;
    });
  }

  Future<void> fetchData(BuildContext context, {int count = 1}) async {
    final report = await fetchCustomerDueReport(
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
              r.customer,
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
        "Customer Details",
        "Grand Total",
        "Returned Amount",
        "Paid",
        "Due",
      ],
    );
  }
}
