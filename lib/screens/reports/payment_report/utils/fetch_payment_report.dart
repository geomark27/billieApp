/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: fetch_payment_report
*/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/reports/payment_report/api/payment_report.dart';
import 'package:salepro/screens/reports/payment_report/models/payment_report.dart';
import 'package:salepro/utils/control_loading.dart';

Future<Data<PaymentReport>> fetchPaymentReport(
    BuildContext context, DateTime start, DateTime end,
    {bool showSnackbar = false, int? count}) async {
  Loading.start(context);
  final report = await PaymentReportAPI.create(
    PaymentReport(
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
