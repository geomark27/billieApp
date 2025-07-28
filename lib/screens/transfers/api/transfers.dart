/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: transfers
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/transfers/models/transfer.dart';

class TransferAPI extends BaseAPI<Transfer> {
  TransferAPI() : super('transfers');

  @override
  Transfer fromJson(Map<String, dynamic> json) => Transfer.fromJson(json);

  static Future<Data<Transfer>> get(String? token, [int count = 1]) async {
    final api = TransferAPI();
    return await api.GET(token: token, count: count);
  }

  static Future<Message> create(
    Transfer transfer,
    String? token,
  ) async {
    final api = TransferAPI();
    return await api.POST(
      data: transfer,
      token: token,
    );
  }

  static Future<Message> update(
      int id, Transfer transfer, String? token) async {
    final api = TransferAPI();
    return await api.PUT(
      id: id,
      data: transfer,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = TransferAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
