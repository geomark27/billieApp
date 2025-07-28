/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: challan_report
*/

import 'package:flutter/material.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/reports/challan_report/models/challan_report.dart';
import 'package:salepro/screens/reports/challan_report/utils/fetch_challan_report.dart';
import 'package:salepro/widgets/list.dart';

class ChallanReportScreen extends StatefulWidget {
  const ChallanReportScreen({
    super.key,
    required this.report,
    required this.start,
    required this.end,
    required this.basedOn,
  });

  final Data<ChallanReport> report;
  final DateTime start;
  final DateTime end;
  final String basedOn;

  @override
  State<ChallanReportScreen> createState() => _ChallanReportScreenState();
}

class _ChallanReportScreenState extends State<ChallanReportScreen> {
  List<ChallanReport> challanReports = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      challanReports = widget.report.data;
    });
  }

  Future<void> fetchData(BuildContext context, {int count = 1}) async {
    final report = await fetchChallanReport(
      context,
      widget.start,
      widget.end,
      basedOn: widget.basedOn,
      count: count,
    );

    setState(() {
      if (count == 1) {
        challanReports = report.data;
      } else {
        challanReports = [
          ...challanReports,
          ...report.data,
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Challan Report",
      requirePagination: widget.report.requirePagination,
      fetchMethod: () async {
        await fetchData(context);
      },
      onRefresh: () async {
        await fetchData(context);
      },
      rows: challanReports
          .map(
            (r) => [
              r.challanNo,
              r.orderNo,
              r.orderDate,
              r.code,
              r.deliveryDate,
              r.salesAmount,
              r.cashPayment,
              r.onlinePayment,
              r.chequePayment,
              r.shippingIncome,
              r.deliveryCharge,
              r.net,
              r.netCash,
            ],
          )
          .toList(),
      columns: [
        "Challan No",
        "Order No",
        "Order Date",
        "Code",
        "Delivery Date",
        "Sales Amount",
        "Cash Payment",
        "Online Payment",
        "Cheque Payment",
        "Shipping Income",
        "Delivery Charge",
        "Net",
        "Net Cash",
      ],
    );
  }
}
