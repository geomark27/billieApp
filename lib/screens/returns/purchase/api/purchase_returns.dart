/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: purchase_returns
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/returns/purchase/models/purchase_return.dart';

class PurchaseReturnAPI extends BaseAPI<PurchaseReturn> {
  PurchaseReturnAPI() : super('return-purchase');

  @override
  PurchaseReturn fromJson(Map<String, dynamic> json) =>
      PurchaseReturn.fromJson(json);

  static Future<Data<PurchaseReturn>> get(String? token,
      [int count = 1]) async {
    final api = PurchaseReturnAPI();
    return await api.GET(token: token, count: count);
  }

  static Future<Message> create(
    PurchaseReturn purchaseReturn,
    String? token,
  ) async {
    final api = PurchaseReturnAPI();
    return await api.POST(
      data: purchaseReturn,
      token: token,
    );
  }
}
