/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: fetch_customer_group_report
*/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/reports/customer_group_report/api/customer_group_report.dart';
import 'package:salepro/screens/reports/customer_group_report/models/customer_group_report.dart';
import 'package:salepro/utils/control_loading.dart';

Future<CustomerGroupReport?> fetchCustomerGroupReport(
    BuildContext context, DateTime start, DateTime end, String customerGroup,
    {bool showSnackbar = false, int? count}) async {
  Loading.start(context);
  final report = await CustomerGroupReportAPI.create(
    CustomerGroupReport(
      startDate: DateFormat('yyyy-MM-dd').format(start),
      endDate: DateFormat('yyyy-MM-dd').format(end),
      customerGroup: customerGroup,
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
