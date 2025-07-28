/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: challan_report
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/reports/challan_report/models/challan_report.dart';

class ChallanReportAPI extends BaseAPI<ChallanReport> {
  ChallanReportAPI() : super('report/challan-report');

  @override
  ChallanReport fromJson(Map<String, dynamic> json) =>
      ChallanReport.fromJson(json);

  static Future<Data<ChallanReport>> create(ChallanReport challanReport,
      {String? token, int? count}) async {
    final api = ChallanReportAPI();
    return await api.POSTFORDATA(
      data: challanReport,
      token: token,
      count: count,
    );
  }
}
