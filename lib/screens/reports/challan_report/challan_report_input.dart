/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: challan_report_input
*/

import 'package:flutter/material.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/reports/challan_report/challan_report.dart';
import 'package:salepro/screens/reports/challan_report/utils/fetch_challan_report.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/date_range_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/select.dart';

class ChallanReportInputScreen extends StatefulWidget {
  const ChallanReportInputScreen({super.key});

  @override
  State<ChallanReportInputScreen> createState() =>
      ChallanReportInputScreenState();
}

class ChallanReportInputScreenState extends State<ChallanReportInputScreen> {
  late TextEditingController dateController;
  String? basedOn = "created_at";
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
    if (start == null || end == null || basedOn == null) return;

    final report = await fetchChallanReport(
      context,
      start!,
      end!,
      basedOn: basedOn!,
    );

    if (report.data.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ChallanReportScreen(
            report: report,
            start: start!,
            end: end!,
            basedOn: basedOn!,
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
        AppSelect(
          hintText: "Based On",
          value: basedOn,
          onChange: (String? value) {
            setState(() {
              basedOn = value;
            });
          },
          items: [
            const {'label': "Created Date", 'value': "created_at"},
            const {'label': "Closing Date", 'value': "closing_date"},
          ],
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['based_on'],
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
