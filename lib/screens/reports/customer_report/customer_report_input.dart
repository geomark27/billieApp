/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_report_input
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/reports/customer_report/customer_report.dart';
import 'package:salepro/screens/reports/customer_report/utils/fetch_customer_report.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/date_range_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/select.dart';

class CustomerReportInputScreen extends StatefulWidget {
  const CustomerReportInputScreen({super.key});

  @override
  State<CustomerReportInputScreen> createState() =>
      CustomerReportInputScreenState();
}

class CustomerReportInputScreenState extends State<CustomerReportInputScreen> {
  late TextEditingController dateController;
  String? customer = "0";
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
    if (start == null || end == null || customer == null) return;

    final report = await fetchCustomerReport(
      context,
      start!,
      end!,
      customer!,
    );

    if (report != null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => CustomerReportScreen(
            report: report,
            start: start!,
            end: end!,
            customer: customer!,
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
      title: "Choose Customer",
      onSubmit: handleSubmit,
      children: [
        AppSelect(
          hintText: "Customer",
          value: customer,
          onChange: (String? value) {
            setState(() {
              customer = value;
            });
          },
          items: context.watch<CommonDataProvider>().selectCustomersData,
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['customer_id'],
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
