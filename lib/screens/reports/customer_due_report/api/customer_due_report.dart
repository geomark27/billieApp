/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_due_report
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/reports/customer_due_report/models/customer_due_report.dart';

class CustomerDueReportAPI extends BaseAPI<CustomerDueReport> {
  CustomerDueReportAPI() : super('report/customer-due-report-data');

  @override
  CustomerDueReport fromJson(Map<String, dynamic> json) =>
      CustomerDueReport.fromJson(json);

  static Future<Data<CustomerDueReport>> create(
      CustomerDueReport customerDueReport,
      {String? token,
      int? count}) async {
    final api = CustomerDueReportAPI();
    return await api.POSTFORDATA(
      data: customerDueReport,
      token: token,
      count: count,
      paginate: false,
    );
  }
}
