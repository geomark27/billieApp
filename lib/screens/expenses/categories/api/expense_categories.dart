/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: expense_categories
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/expenses/categories/models/expense_category.dart';

class ExpenseCategoriesAPI extends BaseAPI<ExpenseCategory> {
  ExpenseCategoriesAPI() : super('expensecategories');

  @override
  ExpenseCategory fromJson(Map<String, dynamic> json) =>
      ExpenseCategory.fromJson(json);

  static Future<Data<ExpenseCategory>> get(String? token) async {
    final api = ExpenseCategoriesAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(
    ExpenseCategory expenseCategory,
    String? token,
  ) async {
    final api = ExpenseCategoriesAPI();
    return await api.POST(
      data: expenseCategory,
      token: token,
    );
  }

  static Future<Message> update(
      int id, ExpenseCategory expenseCategory, String? token) async {
    final api = ExpenseCategoriesAPI();
    return await api.PUT(
      id: id,
      data: expenseCategory,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = ExpenseCategoriesAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
