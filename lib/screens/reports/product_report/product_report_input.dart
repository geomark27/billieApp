/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: product_report_input
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/reports/product_report/product_report.dart';
import 'package:salepro/screens/reports/product_report/utils/fetch_product_report.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/date_range_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/select.dart';

class ProductReportInputScreen extends StatefulWidget {
  const ProductReportInputScreen({super.key});

  @override
  State<ProductReportInputScreen> createState() =>
      ProductyReportInputScreenState();
}

class ProductyReportInputScreenState extends State<ProductReportInputScreen> {
  late TextEditingController dateController;
  String? warehouse = "0";
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
    if (start == null || end == null || warehouse == null) return;

    final report = await fetchProductReport(context, start!, end!, warehouse!);

    if (report.data.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ProductReportScreen(
            report: report,
            start: start!,
            end: end!,
            warehouse: warehouse!,
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
      title: "Choose Your Date",
      onSubmit: handleSubmit,
      children: [
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
        AppSelect(
          hintText: "Warehouse",
          value: warehouse,
          onChange: (String? value) {
            setState(() {
              warehouse = value;
            });
          },
          items: [
            const {'label': "All Warehouses", 'value': "0"},
            ...context.watch<CommonDataProvider>().selectWarehousesData
          ],
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['warehouse_id'],
        ),
      ],
    );
  }
}
