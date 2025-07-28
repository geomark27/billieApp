/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_group_report
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/screens/reports/customer_group_report/models/customer_group_report.dart';

class CustomerGroupReportAPI extends BaseAPI<CustomerGroupReport> {
  CustomerGroupReportAPI() : super('report/customer-group');

  @override
  CustomerGroupReport fromJson(Map<String, dynamic> json) =>
      CustomerGroupReport.fromJson(json);

  static Future<CustomerGroupReport?> create(
      CustomerGroupReport customerGroupReport,
      {String? token,
      int? count}) async {
    final api = CustomerGroupReportAPI();
    return await api.POSTFORSINGLEDATA(
      data: customerGroupReport,
      token: token,
      count: count,
    );
  }
}
