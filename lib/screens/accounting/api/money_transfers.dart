/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: money_transfers
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/accounting/models/money_transfer.dart';

class MoneyTransfersAPI extends BaseAPI<MoneyTransfer> {
  MoneyTransfersAPI() : super('money-transfers');

  @override
  MoneyTransfer fromJson(Map<String, dynamic> json) =>
      MoneyTransfer.fromJson(json);

  static Future<Data<MoneyTransfer>> get(String? token) async {
    final api = MoneyTransfersAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(
      MoneyTransfer moneyTransfer, String? token) async {
    final api = MoneyTransfersAPI();
    return await api.POST(
      data: moneyTransfer,
      token: token,
    );
  }

  static Future<Message> update(
      int id, MoneyTransfer moneyTransfer, String? token) async {
    final api = MoneyTransfersAPI();
    return await api.PUT(
      id: id,
      data: moneyTransfer,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = MoneyTransfersAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
