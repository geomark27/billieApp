/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: user_report_input
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/reports/user_report/user_report.dart';
import 'package:salepro/screens/reports/user_report/utils/fetch_user_report.dart';
import 'package:salepro/utils/show_success_snack_bar.dart';
import 'package:salepro/widgets/date_range_picker.dart';
import 'package:salepro/widgets/form_screen.dart';
import 'package:salepro/widgets/select.dart';

class UserReportInputScreen extends StatefulWidget {
  const UserReportInputScreen({super.key});

  @override
  State<UserReportInputScreen> createState() => UserReportInputScreenState();
}

class UserReportInputScreenState extends State<UserReportInputScreen> {
  late TextEditingController dateController;
  String? user = "0";
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
    if (start == null || end == null || user == null) return;

    final report = await fetchUserReport(
      context,
      start!,
      end!,
      user!,
    );

    if (report != null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => UserReportScreen(
            report: report,
            start: start!,
            end: end!,
            user: user!,
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
      title: "Choose User",
      onSubmit: handleSubmit,
      children: [
        AppSelect(
          hintText: "User",
          value: user,
          onChange: (String? value) {
            setState(() {
              user = value;
            });
          },
          items: context.watch<CommonDataProvider>().selectCustomersData,
          enableFilter: false,
          enableSearch: false,
          errorLine: message?.errors?['user_id'],
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
