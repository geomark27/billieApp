/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: quotations
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/quotations/models/quotation.dart';

class QuotationsAPI extends BaseAPI<Quotation> {
  QuotationsAPI() : super('quotations');

  @override
  Quotation fromJson(Map<String, dynamic> json) => Quotation.fromJson(json);

  static Future<Data<Quotation>> get(String? token, [int count = 1]) async {
    final api = QuotationsAPI();
    return await api.GET(token: token, count: count);
  }

  static Future<Message> create(
    Quotation quotation,
    String? token,
  ) async {
    final api = QuotationsAPI();
    return await api.POST(
      data: quotation,
      token: token,
    );
  }

  static Future<Message> update(
      int id, Quotation quotation, String? token) async {
    final api = QuotationsAPI();
    return await api.PUT(
      id: id,
      data: quotation,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = QuotationsAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
