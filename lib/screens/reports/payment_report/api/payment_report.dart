/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: payment_report
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/reports/payment_report/models/payment_report.dart';

class PaymentReportAPI extends BaseAPI<PaymentReport> {
  PaymentReportAPI() : super('report/payment-report-by-date');

  @override
  PaymentReport fromJson(Map<String, dynamic> json) =>
      PaymentReport.fromJson(json);

  static Future<Data<PaymentReport>> create(PaymentReport paymentReport,
      {String? token, int? count}) async {
    final api = PaymentReportAPI();
    return await api.POSTFORDATA(
      data: paymentReport,
      token: token,
      count: count,
      paginate: false,
    );
  }
}
