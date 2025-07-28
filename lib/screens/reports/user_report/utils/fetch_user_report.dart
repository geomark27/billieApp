/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: fetch_user_report
*/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/reports/user_report/api/user_report.dart';
import 'package:salepro/screens/reports/user_report/models/user_report.dart';
import 'package:salepro/utils/control_loading.dart';

Future<UserReport?> fetchUserReport(
    BuildContext context, DateTime start, DateTime end, String user,
    {bool showSnackbar = false, int? count}) async {
  Loading.start(context);
  final report = await UserReportAPI.create(
    UserReport(
      startDate: DateFormat('yyyy-MM-dd').format(start),
      endDate: DateFormat('yyyy-MM-dd').format(end),
      user: user,
    ),
    token: context.read<CommonDataProvider>().token,
    count: count,
  );

  await Future.delayed(Duration(milliseconds: 100), () {
    // ignore: use_build_context_synchronously
    Loading.stop(context);
  });

  return report;
}
