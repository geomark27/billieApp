/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: fetch_sale_report
*/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/screens/reports/sale_report/api/sale_report.dart';
import 'package:salepro/screens/reports/sale_report/models/sale_report.dart';
import 'package:salepro/utils/control_loading.dart';

Future<Data<SaleReport>> fetchSaleReport(
    BuildContext context, DateTime start, DateTime end, String warehouse,
    {bool showSnackbar = false, int? count}) async {
  Loading.start(context);
  final report = await SaleReportAPI.create(
    SaleReport(
      warehouseId: warehouse,
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
