/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: fetch_challan_report
*/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/reports/challan_report/api/challan_report.dart';
import 'package:salepro/screens/reports/challan_report/models/challan_report.dart';
import 'package:salepro/utils/control_loading.dart';

Future<Data<ChallanReport>> fetchChallanReport(
    BuildContext context, DateTime start, DateTime end,
    {bool showSnackbar = false,
    String basedOn = "closing_date",
    int? count}) async {
  Loading.start(context);
  final report = await ChallanReportAPI.create(
    ChallanReport(
      startDate: DateFormat('yyyy-MM-dd').format(start),
      endDate: DateFormat('yyyy-MM-dd').format(end),
      basedOn: basedOn,
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
