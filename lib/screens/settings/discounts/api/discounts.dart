/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: discounts
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/settings/discounts/models/discount.dart';

class DiscountsAPI extends BaseAPI<Discount> {
  DiscountsAPI() : super('discounts');

  @override
  Discount fromJson(Map<String, dynamic> json) => Discount.fromJson(json);

  static Future<Data<Discount>> get(String? token) async {
    final api = DiscountsAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(
    Discount discount,
    String? token, {
    Map<String, String>? fileData,
  }) async {
    final api = DiscountsAPI();
    return await api.POST(
      data: discount,
      token: token,
      fileData: fileData,
    );
  }

  static Future<Message> update(
      int id, Discount discount, String? token) async {
    final api = DiscountsAPI();
    return await api.PUT(
      id: id,
      data: discount,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = DiscountsAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
