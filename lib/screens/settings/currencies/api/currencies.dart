/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: currencies
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/settings/currencies/models/currency.dart';

class CurrencyAPI extends BaseAPI<Currency> {
  CurrencyAPI() : super('currencies');

  @override
  Currency fromJson(Map<String, dynamic> json) => Currency.fromJson(json);

  static Future<Data<Currency>> get(String? token) async {
    final api = CurrencyAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(
    Currency currency,
    String? token,
  ) async {
    final api = CurrencyAPI();
    return await api.POST(data: currency, token: token);
  }

  static Future<Message> update(
      int id, Currency currency, String? token) async {
    final api = CurrencyAPI();
    return await api.PUT(id: id, data: currency, token: token);
  }

  static Future<Message> delete(int id, String? token) async {
    final api = CurrencyAPI();
    return await api.DELETE(id: id, token: token);
  }
}
