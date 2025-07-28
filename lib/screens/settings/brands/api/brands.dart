/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: brands
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/settings/brands/models/brand.dart';

class BrandAPI extends BaseAPI<Brand> {
  BrandAPI() : super('brands');

  @override
  Brand fromJson(Map<String, dynamic> json) => Brand.fromJson(json);

  static Future<Data<Brand>> get(String? token) async {
    final api = BrandAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(
    Brand brand,
    String? token, {
    Map<String, String>? fileData,
  }) async {
    final api = BrandAPI();
    return await api.POST(data: brand, token: token, fileData: fileData);
  }

  static Future<Message> update(int id, Brand brand, String? token) async {
    final api = BrandAPI();
    return await api.PUT(id: id, data: brand, token: token);
  }

  static Future<Message> delete(int id, String? token) async {
    final api = BrandAPI();
    return await api.DELETE(id: id, token: token);
  }
}
