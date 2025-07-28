/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: suppliers
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/people/suppliers/models/supplier.dart';

class SuppliersAPI extends BaseAPI<Supplier> {
  SuppliersAPI() : super('suppliers');

  @override
  Supplier fromJson(Map<String, dynamic> json) => Supplier.fromJson(json);

  static Future<Data<Supplier>> get(String? token) async {
    final api = SuppliersAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(
    Supplier supplier,
    String? token, {
    Map<String, String>? fileData,
  }) async {
    final api = SuppliersAPI();
    return await api.POST(
      data: supplier,
      token: token,
      fileData: fileData,
    );
  }

  static Future<Message> update(
      int id, Supplier supplier, String? token) async {
    final api = SuppliersAPI();
    return await api.PUT(
      id: id,
      data: supplier,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = SuppliersAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
