/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_report
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/reports/customer_report/models/customer_payment.dart';
import 'package:salepro/screens/reports/customer_report/models/customer_report.dart';
import 'package:salepro/screens/reports/customer_report/models/customer_sale.dart';
import 'package:salepro/screens/reports/customer_report/utils/fetch_customer_report.dart';
import 'package:salepro/widgets/tab_bar_list.dart';

class CustomerReportScreen extends StatefulWidget {
  const CustomerReportScreen({
    super.key,
    required this.report,
    required this.start,
    required this.end,
    required this.customer,
  });

  final CustomerReport report;
  final DateTime start;
  final DateTime end;
  final String customer;

  @override
  State<CustomerReportScreen> createState() => _CustomerReportScreenState();
}

class _CustomerReportScreenState extends State<CustomerReportScreen> {
  List<CustomerPaymentReport> payments = [];
  List<CustomerSaleReport> sales = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      payments = widget.report.payments?.data ?? [];
      sales = widget.report.sales?.data ?? [];
    });
  }

  Future<void> fetchData(BuildContext context, {int count = 1}) async {
    final report = await fetchCustomerReport(
      context,
      widget.start,
      widget.end,
      widget.customer,
      count: count,
    );

    setState(() {
      if (count == 1) {
        payments = report?.payments?.data ?? [];
        sales = report?.sales?.data ?? [];
      } else {
        final updatedPayments = widget.report.payments?.data ?? [];
        final updatedPurchases = widget.report.sales?.data ?? [];

        payments = [...payments, ...updatedPayments];
        sales = [...sales, ...updatedPurchases];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TabBarListScreen(
      title: "Customer Report",
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
      ],
      rows: [
        sales
            .map((p) => [
                  p.date,
                  p.referenceNo,
                  p.warehouse,
                  p.product,
                  p.totalCost,
                  p.grandTotal,
                  p.paid,
                  p.due,
                  p.status,
                ])
            .toList(),
        payments
            .map((p) => [
                  p.date,
                  p.reference,
                  p.saleReference,
                  p.amount,
                  p.payingMethod,
                ])
            .toList(),
      ],
      columns: [
        [
          "Date",
          "Reference",
          "Warehouse",
          "Product(Qty)",
          "Total Cost",
          "Grand Total",
          "Paid",
          "Due",
          "Status"
        ],
        [
          "Date",
          "Payment Reference",
          "Sale Reference",
          "Amount",
          "Paid Method",
        ],
      ],
    );
  }
}
