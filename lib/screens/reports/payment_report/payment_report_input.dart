/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: payment_report_input
*/

import 'package:flutter/material.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/reports/payment_report/payment_report.dart';
import 'package:salepro/screens/reports/payment_report/utils/fetch_payment_report.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/date_range_picker.dart';
import 'package:salepro/widgets/form_screen.dart';

class PaymentReportInputScreen extends StatefulWidget {
  const PaymentReportInputScreen({super.key});

  @override
  State<PaymentReportInputScreen> createState() =>
      PaymentReportInputScreenState();
}

class PaymentReportInputScreenState extends State<PaymentReportInputScreen> {
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

    final report = await fetchPaymentReport(context, start!, end!);

    if (report.data.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => PaymentReportScreen(
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
