/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: supplier_report
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/reports/supplier_report/models/supplier_payment.dart';
import 'package:salepro/screens/reports/supplier_report/models/supplier_purchase.dart';
import 'package:salepro/screens/reports/supplier_report/models/supplier_quotation.dart';
import 'package:salepro/screens/reports/supplier_report/models/supplier_report.dart';
import 'package:salepro/screens/reports/supplier_report/models/supplier_return.dart';
import 'package:salepro/screens/reports/supplier_report/utils/fetch_supplier_report.dart';
import 'package:salepro/widgets/tab_bar_list.dart';

class SupplierReportScreen extends StatefulWidget {
  const SupplierReportScreen({
    super.key,
    required this.report,
    required this.start,
    required this.end,
    required this.supplier,
  });

  final SupplierReport report;
  final DateTime start;
  final DateTime end;
  final String supplier;

  @override
  State<SupplierReportScreen> createState() => _SupplierReportScreenState();
}

class _SupplierReportScreenState extends State<SupplierReportScreen> {
  List<SupplierPaymentReport> payments = [];
  List<SupplierPurchaseReport> purchases = [];
  List<SupplierReturnReport> returns = [];
  List<SupplierQuotationReport> quotations = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      payments = widget.report.payments?.data ?? [];
      purchases = widget.report.purchases?.data ?? [];
      returns = widget.report.returns?.data ?? [];
      quotations = widget.report.quotations?.data ?? [];
    });
  }

  Future<void> fetchData(BuildContext context, {int count = 1}) async {
    final report = await fetchSupplierReport(
      context,
      widget.start,
      widget.end,
      widget.supplier,
      count: count,
    );

    setState(() {
      if (count == 1) {
        payments = report?.payments?.data ?? [];
        purchases = report?.purchases?.data ?? [];
        returns = report?.returns?.data ?? [];
        quotations = report?.quotations?.data ?? [];
      } else {
        final updatedPayments = widget.report.payments?.data ?? [];
        final updatedPurchases = widget.report.purchases?.data ?? [];
        final updatedReturns = widget.report.returns?.data ?? [];
        final updatedQuotations = widget.report.quotations?.data ?? [];

        payments = [...payments, ...updatedPayments];
        purchases = [...purchases, ...updatedPurchases];
        returns = [...returns, ...updatedReturns];
        quotations = [...quotations, ...updatedQuotations];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TabBarListScreen(
      title: "Supplier Report",
      requirePagination: true,
      fetchMethod: () async {
        await fetchData(context);
      },
      onRefresh: () async {
        await fetchData(context);
      },
      tabs: [
        "Purchase",
        "Payment",
        "Return",
        "Quotation",
      ],
      rows: [
        purchases
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
                  p.purchaseReference,
                  p.amount,
                  p.paidMethod,
                ])
            .toList(),
        returns
            .map((p) => [
                  p.date,
                  p.referenceNo,
                  p.warehouse,
                  p.product,
                  p.grandTotal,
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
          "Purchase Reference",
          "Amount",
          "Paid Method",
        ],
        [
          "Date",
          "Reference",
          "Warehouse",
          "Product(Qty)",
          "Grand Total",
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
