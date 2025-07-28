/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: fetch_customer_report
*/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/reports/customer_report/api/customer_report.dart';
import 'package:salepro/screens/reports/customer_report/models/customer_report.dart';
import 'package:salepro/utils/control_loading.dart';

Future<CustomerReport?> fetchCustomerReport(
    BuildContext context, DateTime start, DateTime end, String customer,
    {bool showSnackbar = false, int? count}) async {
  Loading.start(context);
  final report = await CustomerReportAPI.create(
    CustomerReport(
      startDate: DateFormat('yyyy-MM-dd').format(start),
      endDate: DateFormat('yyyy-MM-dd').format(end),
      customer: customer,
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
