/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: supplier_report
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/screens/reports/supplier_report/models/supplier_report.dart';

class SupplierReportAPI extends BaseAPI<SupplierReport> {
  SupplierReportAPI() : super('report/supplier');

  @override
  SupplierReport fromJson(Map<String, dynamic> json) =>
      SupplierReport.fromJson(json);

  static Future<SupplierReport?> create(SupplierReport supplierReport,
      {String? token, int? count}) async {
    final api = SupplierReportAPI();
    return await api.POSTFORSINGLEDATA(
      data: supplierReport,
      token: token,
      count: count,
    );
  }
}
