/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: summary_report
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/reports/summary_report/models/summary_report.dart';

class SummaryReportAPI extends BaseAPI<SummaryReport> {
  SummaryReportAPI() : super('report/profit-loss');

  @override
  SummaryReport fromJson(Map<String, dynamic> json) =>
      SummaryReport.fromJson(json);

  static Future<Data<SummaryReport>> create(SummaryReport summaryReport,
      {String? token, int? count}) async {
    final api = SummaryReportAPI();
    return await api.POSTFORDATA(
      data: summaryReport,
      token: token,
      count: count,
    );
  }
}
