/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: sale_returns
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/returns/sale/models/sale_return.dart';

class SaleReturnAPI extends BaseAPI<SaleReturn> {
  SaleReturnAPI() : super('return-sale');

  @override
  SaleReturn fromJson(Map<String, dynamic> json) => SaleReturn.fromJson(json);

  static Future<Data<SaleReturn>> get(String? token, [int count = 1]) async {
    final api = SaleReturnAPI();
    return await api.GET(token: token, count: count);
  }

  static Future<Message> create(
    SaleReturn saleReturn,
    String? token,
  ) async {
    final api = SaleReturnAPI();
    return await api.POST(
      data: saleReturn,
      token: token,
    );
  }
}
