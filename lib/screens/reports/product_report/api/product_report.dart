/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: product_report
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/reports/product_report/models/product_report.dart';

class ProductReportAPI extends BaseAPI<ProductReport> {
  ProductReportAPI() : super('report/product-report');

  @override
  ProductReport fromJson(Map<String, dynamic> json) =>
      ProductReport.fromJson(json);

  static Future<Data<ProductReport>> create(ProductReport productReport,
      {String? token, int? count}) async {
    final api = ProductReportAPI();
    return await api.POSTFORDATA(
      data: productReport,
      token: token,
      count: count,
    );
  }
}
