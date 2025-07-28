/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: product_categories
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/products/categories/models/product_category.dart';

class ProductCategoriesAPI extends BaseAPI<ProductCategory> {
  ProductCategoriesAPI() : super('categories');

  @override
  ProductCategory fromJson(Map<String, dynamic> json) =>
      ProductCategory.fromJson(json);

  static Future<Data<ProductCategory>> get(String? token) async {
    final api = ProductCategoriesAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(
    ProductCategory productCategory,
    String? token, {
    Map<String, String>? fileData,
  }) async {
    final api = ProductCategoriesAPI();
    return await api.POST(
      data: productCategory,
      token: token,
      fileData: fileData,
    );
  }

  static Future<Message> update(
      int id, ProductCategory productCategory, String? token) async {
    final api = ProductCategoriesAPI();
    return await api.PUT(
      id: id,
      data: productCategory,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = ProductCategoriesAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
