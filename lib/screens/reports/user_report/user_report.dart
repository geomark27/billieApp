/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: user_report
*/

import 'package:flutter/material.dart';
import 'package:salepro/screens/reports/user_report/models/user_expense.dart';
import 'package:salepro/screens/reports/user_report/models/user_payment.dart';
import 'package:salepro/screens/reports/user_report/models/user_payroll.dart';
import 'package:salepro/screens/reports/user_report/models/user_purchase.dart';
import 'package:salepro/screens/reports/user_report/models/user_quotation.dart';
import 'package:salepro/screens/reports/user_report/models/user_report.dart';
import 'package:salepro/screens/reports/user_report/models/user_sale.dart';
import 'package:salepro/screens/reports/user_report/models/user_transfer.dart';
import 'package:salepro/screens/reports/user_report/utils/fetch_user_report.dart';
import 'package:salepro/widgets/tab_bar_list.dart';

class UserReportScreen extends StatefulWidget {
  const UserReportScreen({
    super.key,
    required this.report,
    required this.start,
    required this.end,
    required this.user,
  });

  final UserReport report;
  final DateTime start;
  final DateTime end;
  final String user;

  @override
  State<UserReportScreen> createState() => _UserReportScreenState();
}

class _UserReportScreenState extends State<UserReportScreen> {
  List<UserPaymentReport> payments = [];
  List<UserPurchaseReport> purchases = [];
  List<UserSaleReport> sales = [];
  List<UserQuotationReport> quotations = [];
  List<UserTransferReport> transfers = [];
  List<UserExpenseReport> expenses = [];
  List<UserPayrollReport> payrolls = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      payments = widget.report.payments?.data ?? [];
      purchases = widget.report.purchases?.data ?? [];
      sales = widget.report.sales?.data ?? [];
      quotations = widget.report.quotations?.data ?? [];
      transfers = widget.report.transfers?.data ?? [];
      expenses = widget.report.expenses?.data ?? [];
      payrolls = widget.report.payrolls?.data ?? [];
    });
  }

  Future<void> fetchData(BuildContext context, {int count = 1}) async {
    final report = await fetchUserReport(
      context,
      widget.start,
      widget.end,
      widget.user,
      count: count,
    );

    setState(() {
      if (count == 1) {
        payments = report?.payments?.data ?? [];
        purchases = report?.purchases?.data ?? [];
        sales = report?.sales?.data ?? [];
        quotations = report?.quotations?.data ?? [];
        transfers = report?.transfers?.data ?? [];
        expenses = report?.expenses?.data ?? [];
        payrolls = report?.payrolls?.data ?? [];
      } else {
        final updatedPayments = widget.report.payments?.data ?? [];
        final updatedPurchases = widget.report.purchases?.data ?? [];
        final updatedSales = widget.report.sales?.data ?? [];
        final updatedQuotations = widget.report.quotations?.data ?? [];
        final updatedTransfers = widget.report.transfers?.data ?? [];
        final updatedExpenses = widget.report.expenses?.data ?? [];
        final updatedPayrolls = widget.report.payrolls?.data ?? [];

        payments = [...payments, ...updatedPayments];
        purchases = [...purchases, ...updatedPurchases];
        sales = [...sales, ...updatedSales];
        quotations = [...quotations, ...updatedQuotations];
        transfers = [...transfers, ...updatedTransfers];
        expenses = [...expenses, ...updatedExpenses];
        payrolls = [...payrolls, ...updatedPayrolls];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TabBarListScreen(
      title: "User Report",
      requirePagination: true,
      fetchMethod: () async {
        await fetchData(context);
      },
      onRefresh: () async {
        await fetchData(context);
      },
      tabs: [
        "Sale",
        "Purchase",
        "Quotation",
        "Transfer",
        "Payment",
        "Expense",
        "Payroll",
      ],
      rows: [
        sales
            .map((p) => [
                  p.date,
                  p.referenceNo,
                  p.customer,
                  p.warehouse,
                  p.product,
                  p.grandTotal,
                  p.paid,
                  p.due,
                  p.status,
                ])
            .toList(),
        purchases
            .map((p) => [
                  p.date,
                  p.referenceNo,
                  p.supplier,
                  p.warehouse,
                  p.product,
                  p.grandTotal,
                  p.paid,
                  p.balance,
                  p.status,
                ])
            .toList(),
        quotations
            .map((p) => [
                  p.date,
                  p.referenceNo,
                  p.customer,
                  p.warehouse,
                  p.product,
                  p.grandTotal,
                  p.status,
                ])
            .toList(),
        transfers
            .map((p) => [
                  p.date,
                  p.referenceNo,
                  p.from,
                  p.to,
                  p.product,
                  p.grandTotal,
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
        expenses
            .map((p) => [
                  p.date,
                  p.referenceNo,
                  p.warehouse,
                  p.category,
                  p.amount,
                  p.note,
                ])
            .toList(),
        payrolls
            .map((p) => [
                  p.date,
                  p.paymentReference,
                  p.employee,
                  p.amount,
                  p.paidMethod,
                ])
            .toList(),
      ],
      columns: [
        [
          "Date",
          "Reference",
          "Customer",
          "Warehouse",
          "Product(Qty)",
          "Grand Total",
          "Paid",
          "Due",
          "Status"
        ],
        [
          "Date",
          "Reference",
          "Supplier",
          "Warehouse",
          "Product(Qty)",
          "Grand Total",
          "Paid",
          "Balance",
          "Status"
        ],
        [
          "Date",
          "Reference",
          "Customer",
          "Warehouse",
          "Product(Qty)",
          "Grand Total",
          "Status",
        ],
        [
          "Date",
          "Reference",
          "From",
          "To",
          "Product(Qty)",
          "Grand Total",
          "Status",
        ],
        [
          "Date",
          "Reference",
          "Amount",
          "Paid Method",
        ],
        [
          "Date",
          "Reference",
          "Warehouse",
          "Category",
          "Amount",
          "Note",
        ],
        [
          "Date",
          "Reference",
          "Employee",
          "Amount",
          "Method",
        ],
      ],
    );
  }
}
