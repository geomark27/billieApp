/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: income_categories
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/incomes/categories/models/income_category.dart';

class IncomeCategoriesAPI extends BaseAPI<IncomeCategory> {
  IncomeCategoriesAPI() : super('incomecategories');

  @override
  IncomeCategory fromJson(Map<String, dynamic> json) =>
      IncomeCategory.fromJson(json);

  static Future<Data<IncomeCategory>> get(String? token) async {
    final api = IncomeCategoriesAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(
      IncomeCategory incomeCategory, String? token) async {
    final api = IncomeCategoriesAPI();
    return await api.POST(
      data: incomeCategory,
      token: token,
    );
  }

  static Future<Message> update(
      int id, IncomeCategory incomeCategory, String? token) async {
    final api = IncomeCategoriesAPI();
    return await api.PUT(
      id: id,
      data: incomeCategory,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = IncomeCategoriesAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
