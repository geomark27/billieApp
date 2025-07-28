/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: payment_report
*/

import 'package:flutter/material.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/reports/payment_report/models/payment_report.dart';
import 'package:salepro/screens/reports/payment_report/utils/fetch_payment_report.dart';
import 'package:salepro/widgets/list.dart';

class PaymentReportScreen extends StatefulWidget {
  const PaymentReportScreen(
      {super.key,
      required this.report,
      required this.start,
      required this.end});

  final Data<PaymentReport> report;
  final DateTime start;
  final DateTime end;

  @override
  State<PaymentReportScreen> createState() => _PaymentReportScreenState();
}

class _PaymentReportScreenState extends State<PaymentReportScreen> {
  List<PaymentReport> paymentReports = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      paymentReports = widget.report.data;
    });
  }

  Future<void> fetchData(BuildContext context, {int count = 1}) async {
    final report = await fetchPaymentReport(
      context,
      widget.start,
      widget.end,
      count: count,
    );

    setState(() {
      if (count == 1) {
        paymentReports = report.data;
      } else {
        paymentReports = [
          ...paymentReports,
          ...report.data,
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Payment Report",
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
      rows: paymentReports
          .map(
            (r) => [
              r.createdAt,
              r.paymentReference,
              r.saleReference,
              r.purchaseReference,
              r.amount,
              r.payingMethod,
            ],
          )
          .toList(),
      columns: [
        "Date",
        "Payment Reference",
        "Sale Reference",
        "Purchased Amount",
        "Purchased Qty",
        "Sold Amount",
      ],
    );
  }
}
