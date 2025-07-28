/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: warehouse
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/settings/warehouse/models/warehouse.dart';

class WarehouseAPI extends BaseAPI<Warehouse> {
  WarehouseAPI() : super('warehouses');

  @override
  Warehouse fromJson(Map<String, dynamic> json) => Warehouse.fromJson(json);

  static Future<Data<Warehouse>> get(String? token) async {
    final api = WarehouseAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(Warehouse data, String? token) async {
    final api = WarehouseAPI();
    return await api.POST(data: data, token: token);
  }

  static Future<Message> update(int id, Warehouse data, String? token) async {
    final api = WarehouseAPI();
    return await api.PUT(id: id, data: data, token: token);
  }

  static Future<Message> delete(int id, String? token) async {
    final api = WarehouseAPI();
    return await api.DELETE(id: id, token: token);
  }
}
