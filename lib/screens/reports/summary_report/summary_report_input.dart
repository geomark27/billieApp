/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: summary_report_input
*/

import 'package:flutter/material.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/reports/summary_report/summary_report.dart';
import 'package:salepro/screens/reports/summary_report/utils/fetch_summary_report.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/date_range_picker.dart';
import 'package:salepro/widgets/form_screen.dart';

class SummaryReportInputScreen extends StatefulWidget {
  const SummaryReportInputScreen({super.key});

  @override
  State<SummaryReportInputScreen> createState() =>
      _SummaryReportInputScreenState();
}

class _SummaryReportInputScreenState extends State<SummaryReportInputScreen> {
  late TextEditingController dateController;
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
    if (start == null || end == null) return;

    final report = await fetchSummaryReport(context, start!, end!);

    if (report.data.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => SummaryReportScreen(
            report: report,
            start: start!,
            end: end!,
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
      ],
    );
  }
}
