/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: supplier_report_input
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/reports/supplier_report/supplier_report.dart';
import 'package:salepro/screens/reports/supplier_report/utils/fetch_supplier_report.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/date_range_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/select.dart';

class SupplierReportInputScreen extends StatefulWidget {
  const SupplierReportInputScreen({super.key});

  @override
  State<SupplierReportInputScreen> createState() =>
      SupplierReportInputScreenState();
}

class SupplierReportInputScreenState extends State<SupplierReportInputScreen> {
  late TextEditingController dateController;
  String? supplier = "0";
  DateTime? start;
  DateTime? end;
  Message? message;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    if (start == null || end == null || supplier == null) return;

    final report = await fetchSupplierReport(
      context,
      start!,
      end!,
      supplier!,
    );

    if (report != null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => SupplierReportScreen(
            report: report,
            start: start!,
            end: end!,
            supplier: supplier!,
          ),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar("No Data found!", context, type: "error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: "Choose Supplier",
      onSubmit: handleSubmit,
      children: [
        AppSelect(
          hintText: "Supplier",
          value: supplier,
          onChange: (String? value) {
            setState(() {
              supplier = value;
            });
          },
          items: context.watch<CommonDataProvider>().selectSuppliersData,
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['supplier_id'],
        ),
        AppDateRangePicker(
          hintText: "Date Range",
          controller: dateController,
          onChanged: (s, e) {
            setState(() {
              start = s;
              end = e;
            });
          },
          errorLine: [
            if (message?.errors?['start_date'] != null)
              ...message?.errors?['start_date'],
            if (message?.errors?['end_date'] != null)
              ...message?.errors?['end_date'],
          ],
        ),
      ],
    );
  }
}
