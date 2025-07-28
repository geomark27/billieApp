/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: biller_report
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/reports/biller_report/models/biller_payment.dart';
import 'package:salepro/screens/reports/biller_report/models/biller_quotation.dart';
import 'package:salepro/screens/reports/biller_report/models/biller_report.dart';
import 'package:salepro/screens/reports/biller_report/models/biller_sale.dart';
import 'package:salepro/screens/reports/biller_report/utils/fetch_biller_report.dart';
import 'package:salepro/widgets/tab_bar_list.dart';

class BillerReportScreen extends StatefulWidget {
  const BillerReportScreen({
    super.key,
    required this.report,
    required this.start,
    required this.end,
    required this.biller,
  });

  final BillerReport report;
  final DateTime start;
  final DateTime end;
  final String biller;

  @override
  State<BillerReportScreen> createState() => _BillerReportScreenState();
}

class _BillerReportScreenState extends State<BillerReportScreen> {
  List<BillerPaymentReport> payments = [];
  List<BillerSaleReport> sales = [];
  List<BillerQuotationReport> quotations = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      payments = widget.report.payments?.data ?? [];
      sales = widget.report.sales?.data ?? [];
      quotations = widget.report.quotations?.data ?? [];
    });
  }

  Future<void> fetchData(BuildContext context, {int count = 1}) async {
    final report = await fetchBillerReport(
      context,
      widget.start,
      widget.end,
      widget.biller,
      count: count,
    );

    setState(() {
      if (count == 1) {
        payments = report?.payments?.data ?? [];
        sales = report?.sales?.data ?? [];
        quotations = report?.quotations?.data ?? [];
      } else {
        final updatedPayments = widget.report.payments?.data ?? [];
        final updatedSales = widget.report.sales?.data ?? [];
        final updatedQuotations = widget.report.quotations?.data ?? [];

        payments = [...payments, ...updatedPayments];
        sales = [...sales, ...updatedSales];
        quotations = [...quotations, ...updatedQuotations];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TabBarListScreen(
      title: "Biller Report",
      requirePagination: true,
      fetchMethod: () async {
        await fetchData(context);
      },
      onRefresh: () async {
        await fetchData(context);
      },
      tabs: [
        "Sale",
        "Payment",
        "Quotation",
      ],
      rows: [
        sales
            .map((p) => [
                  p.date,
                  p.referenceNo,
                  p.warehouse,
                  p.product,
                  p.grandTotal,
                  p.paid,
                  p.balance,
                  p.status,
                ])
            .toList(),
        payments
            .map((p) => [
                  p.date,
                  p.paymentReference,
                  p.amount,
                  p.paidMethod,
                ])
            .toList(),
        quotations
            .map((p) => [
                  p.date,
                  p.referenceNo,
                  p.warehouse,
                  p.customer,
                  p.product,
                  p.grandTotal,
                  p.status,
                ])
            .toList(),
      ],
      columns: [
        [
          "Date",
          "Reference",
          "Warehouse",
          "Product(Qty)",
          "Grand Total",
          "Paid",
          "Balance",
          "Status"
        ],
        [
          "Date",
          "Payment Reference",
          "Amount",
          "Paid Method",
        ],
        [
          "Date",
          "Reference",
          "Warehouse",
          "Customer",
          "Product(Qty)",
          "Grand Total",
          "Status",
        ],
      ],
    );
  }
}
