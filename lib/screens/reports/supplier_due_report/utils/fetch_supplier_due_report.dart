/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: fetch_supplier_due_report
*/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/reports/supplier_due_report/api/supplier_due_report.dart';
import 'package:salepro/screens/reports/supplier_due_report/models/supplier_due_report.dart';
import 'package:salepro/utils/control_loading.dart';

Future<Data<SupplierDueReport>> fetchSupplierDueReport(
    BuildContext context, DateTime start, DateTime end,
    {bool showSnackbar = false, int? count}) async {
  Loading.start(context);
  final report = await SupplierDueReportAPI.create(
    SupplierDueReport(
      startDate: DateFormat('yyyy-MM-dd').format(start),
      endDate: DateFormat('yyyy-MM-dd').format(end),
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
