/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: billers
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/people/biller/models/biller.dart';

class BillersAPI extends BaseAPI<Biller> {
  BillersAPI() : super('billers');

  @override
  Biller fromJson(Map<String, dynamic> json) => Biller.fromJson(json);

  static Future<Data<Biller>> get(String? token, [int count = 1]) async {
    final api = BillersAPI();
    return await api.GET(token: token, count: count);
  }

  static Future<Message> create(
    Biller biller,
    String? token,
  ) async {
    final api = BillersAPI();
    return await api.POST(
      data: biller,
      token: token,
    );
  }

  static Future<Message> update(int id, Biller biller, String? token) async {
    final api = BillersAPI();
    return await api.PUT(
      id: id,
      data: biller,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = BillersAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
