/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: taxes
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/settings/taxes/models/tax.dart';

class TaxAPI extends BaseAPI<Tax> {
  TaxAPI() : super('taxes');

  @override
  Tax fromJson(Map<String, dynamic> json) => Tax.fromJson(json);

  static Future<Data<Tax>> get(String? token) async {
    final api = TaxAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(
    Tax tax,
    String? token,
  ) async {
    final api = TaxAPI();
    return await api.POST(data: tax, token: token);
  }

  static Future<Message> update(int id, Tax tax, String? token) async {
    final api = TaxAPI();
    return await api.PUT(id: id, data: tax, token: token);
  }

  static Future<Message> delete(int id, String? token) async {
    final api = TaxAPI();
    return await api.DELETE(id: id, token: token);
  }
}
