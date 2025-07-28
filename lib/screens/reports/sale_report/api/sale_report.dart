/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: sale_report
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/reports/sale_report/models/sale_report.dart';

class SaleReportAPI extends BaseAPI<SaleReport> {
  SaleReportAPI() : super('report/sale-report');

  @override
  SaleReport fromJson(Map<String, dynamic> json) => SaleReport.fromJson(json);

  static Future<Data<SaleReport>> create(SaleReport saleReport,
      {String? token, int? count}) async {
    final api = SaleReportAPI();
    return await api.POSTFORDATA(
      data: saleReport,
      token: token,
      count: count,
    );
  }
}
