/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_report
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/reports/customer_group_report/models/customer_group_payment.dart';
import 'package:salepro/screens/reports/customer_group_report/models/customer_group_report.dart';
import 'package:salepro/screens/reports/customer_group_report/models/customer_group_sale.dart';
import 'package:salepro/screens/reports/customer_group_report/utils/fetch_customer_group_report.dart';
import 'package:salepro/widgets/tab_bar_list.dart';

class CustomerGroupReportScreen extends StatefulWidget {
  const CustomerGroupReportScreen({
    super.key,
    required this.report,
    required this.start,
    required this.end,
    required this.customer,
  });

  final CustomerGroupReport report;
  final DateTime start;
  final DateTime end;
  final String customer;

  @override
  State<CustomerGroupReportScreen> createState() =>
      _CustomerGroupReportScreenState();
}

class _CustomerGroupReportScreenState extends State<CustomerGroupReportScreen> {
  List<CustomerGroupPaymentReport> payments = [];
  List<CustomerGroupSaleReport> sales = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      payments = widget.report.payments?.data ?? [];
      sales = widget.report.sales?.data ?? [];
    });
  }

  Future<void> fetchData(BuildContext context, {int count = 1}) async {
    final report = await fetchCustomerGroupReport(
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
      title: "Customer Group Report",
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
                  p.customer,
                  p.product,
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
                  p.customer,
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
          "Customer",
          "Product(Qty)",
          "Grand Total",
          "Paid",
          "Due",
          "Status"
        ],
        [
          "Date",
          "Payment Reference",
          "Sale Reference",
          "Customer",
          "Amount",
          "Paid Method",
        ],
      ],
    );
  }
}
