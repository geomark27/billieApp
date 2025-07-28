/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: supplier_due_report
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/reports/supplier_due_report/models/supplier_due_report.dart';

class SupplierDueReportAPI extends BaseAPI<SupplierDueReport> {
  SupplierDueReportAPI() : super('report/supplier-due-report-data');

  @override
  SupplierDueReport fromJson(Map<String, dynamic> json) =>
      SupplierDueReport.fromJson(json);

  static Future<Data<SupplierDueReport>> create(
      SupplierDueReport supplierDueReport,
      {String? token,
      int? count}) async {
    final api = SupplierDueReportAPI();
    return await api.POSTFORDATA(
      data: supplierDueReport,
      token: token,
      count: count,
      paginate: false,
    );
  }
}
