/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: purchases
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/purchases/models/purchase.dart';

class PurchaseAPI extends BaseAPI<Purchase> {
  PurchaseAPI() : super('purchases');

  @override
  Purchase fromJson(Map<String, dynamic> json) => Purchase.fromJson(json);

  static Future<Data<Purchase>> get(String? token, [int count = 1]) async {
    final api = PurchaseAPI();
    return await api.GET(token: token, count: count);
  }

  static Future<Message> create(
    Purchase purchase,
    String? token,
  ) async {
    final api = PurchaseAPI();
    return await api.POST(
      data: purchase,
      token: token,
    );
  }

  static Future<Message> update(
      int id, Purchase purchase, String? token) async {
    final api = PurchaseAPI();
    return await api.PUT(
      id: id,
      data: purchase,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = PurchaseAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
