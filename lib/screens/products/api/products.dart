/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: products
*/

import 'dart:convert';

import 'package:salepro/api/base.dart';
import 'package:salepro/api/client.dart';
import 'package:salepro/constants/keys.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/products/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductsAPI extends BaseAPI<Product> {
  ProductsAPI() : super('products');

  @override
  Product fromJson(Map<String, dynamic> json) => Product.fromJson(json);

  static Future<Data<Product>> get(
    String? token,
    int count, {
    bool paginate = true,
  }) async {
    final api = ProductsAPI();
    return await api.GET(
      token: token,
      count: count,
      perPage: 20,
      paginate: paginate,
    );
  }

  static Future<String> generateCode(String? token) async {
    final api = ProductsAPI();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiUrl = prefs.getString(AppKeys.saleproInstallURL) ?? defaultApiURL;
    String spToken = prefs.getString(AppKeys.saleproSetupToken) ?? "";

    final res = await http.get(
      Uri.parse(
        '$apiUrl/generate-code?token=$spToken',
      ),
      headers: api.buildHeaders(token),
    );

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      return body['code'] ?? "";
    } else {
      return "";
    }
  }

  static Future<Message> create(
    Product product,
    String? token, {
    Map<String, String>? fileData,
  }) async {
    final api = ProductsAPI();
    return await api.POST(
      data: product,
      token: token,
      fileData: fileData,
    );
  }

  static Future<Message> update(int id, Product product, String? token) async {
    final api = ProductsAPI();
    return await api.PUT(
      id: id,
      data: product,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = ProductsAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
