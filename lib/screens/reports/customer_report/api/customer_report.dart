/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_report
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/screens/reports/customer_report/models/customer_report.dart';

class CustomerReportAPI extends BaseAPI<CustomerReport> {
  CustomerReportAPI() : super('report/customer-report');

  @override
  CustomerReport fromJson(Map<String, dynamic> json) =>
      CustomerReport.fromJson(json);

  static Future<CustomerReport?> create(CustomerReport customerReport,
      {String? token, int? count}) async {
    final api = CustomerReportAPI();
    return await api.POSTFORSINGLEDATA(
      data: customerReport,
      token: token,
      count: count,
    );
  }
}
