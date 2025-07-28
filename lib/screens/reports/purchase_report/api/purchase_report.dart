/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: purchase_report
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/reports/purchase_report/models/purchase_report.dart';

class PurchaseReportAPI extends BaseAPI<PurchaseReport> {
  PurchaseReportAPI() : super('report/purchase');

  @override
  PurchaseReport fromJson(Map<String, dynamic> json) =>
      PurchaseReport.fromJson(json);

  static Future<Data<PurchaseReport>> create(PurchaseReport purchaseReport,
      {String? token, int? count}) async {
    final api = PurchaseReportAPI();
    return await api.POSTFORDATA(
      data: purchaseReport,
      token: token,
      count: count,
    );
  }
}
