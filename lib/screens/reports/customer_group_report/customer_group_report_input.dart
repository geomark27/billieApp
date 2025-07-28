/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_group_report_input
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/reports/customer_group_report/customer_report.dart';
import 'package:salepro/screens/reports/customer_group_report/utils/fetch_customer_group_report.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/date_range_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/select.dart';

class CustomerGroupReportInputScreen extends StatefulWidget {
  const CustomerGroupReportInputScreen({super.key});

  @override
  State<CustomerGroupReportInputScreen> createState() =>
      CustomerGroupReportInputScreenState();
}

class CustomerGroupReportInputScreenState
    extends State<CustomerGroupReportInputScreen> {
  late TextEditingController dateController;
  String? customerGroup = "0";
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
    if (start == null || end == null || customerGroup == null) return;

    final report = await fetchCustomerGroupReport(
      context,
      start!,
      end!,
      customerGroup!,
    );

    if (report != null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => CustomerGroupReportScreen(
            report: report,
            start: start!,
            end: end!,
            customer: customerGroup!,
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
      title: "Choose Customer Group",
      onSubmit: handleSubmit,
      children: [
        AppSelect(
          hintText: "Customer Group",
          value: customerGroup,
          onChange: (String? value) {
            setState(() {
              customerGroup = value;
            });
          },
          items: context.watch<CommonDataProvider>().selectCustomersGroupData,
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['customer_group_id'],
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
