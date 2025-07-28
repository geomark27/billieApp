/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: biller_report_input
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/reports/biller_report/biller_report.dart';
import 'package:salepro/screens/reports/biller_report/utils/fetch_biller_report.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/date_range_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/select.dart';

class BillerReportInputScreen extends StatefulWidget {
  const BillerReportInputScreen({super.key});

  @override
  State<BillerReportInputScreen> createState() =>
      BillerReportInputScreenState();
}

class BillerReportInputScreenState extends State<BillerReportInputScreen> {
  late TextEditingController dateController;
  String? biller = "0";
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
    if (start == null || end == null || biller == null) return;

    final report = await fetchBillerReport(
      context,
      start!,
      end!,
      biller!,
    );

    if (report != null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => BillerReportScreen(
            report: report,
            start: start!,
            end: end!,
            biller: biller!,
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
      title: "Choose Biller",
      onSubmit: handleSubmit,
      children: [
        AppSelect(
          hintText: "Biller",
          value: biller,
          onChange: (String? value) {
            setState(() {
              biller = value;
            });
          },
          items: context.watch<CommonDataProvider>().selectBillersData,
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['biller_id'],
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
