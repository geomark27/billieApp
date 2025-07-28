/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: biller_report
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/screens/reports/biller_report/models/biller_report.dart';

class BillerReportAPI extends BaseAPI<BillerReport> {
  BillerReportAPI() : super('report/biller-report');

  @override
  BillerReport fromJson(Map<String, dynamic> json) =>
      BillerReport.fromJson(json);

  static Future<BillerReport?> create(BillerReport billerReport,
      {String? token, int? count}) async {
    final api = BillerReportAPI();
    return await api.POSTFORSINGLEDATA(
      data: billerReport,
      token: token,
      count: count,
    );
  }
}
