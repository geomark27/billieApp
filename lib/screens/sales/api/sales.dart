/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: sales
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/sales/models/sale.dart';

class SaleAPI extends BaseAPI<Sale> {
  SaleAPI() : super('sales');

  @override
  Sale fromJson(Map<String, dynamic> json) => Sale.fromJson(json);

  static Future<Data<Sale>> get(String? token, [int count = 1]) async {
    final api = SaleAPI();
    return await api.GET(token: token, count: count);
  }

  static Future<Message> create(
    Sale sale,
    String? token,
  ) async {
    final api = SaleAPI();
    return await api.POST(
      data: sale,
      token: token,
    );
  }

  static Future<Message> update(int id, Sale sale, String? token) async {
    final api = SaleAPI();
    return await api.PUT(
      id: id,
      data: sale,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = SaleAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
