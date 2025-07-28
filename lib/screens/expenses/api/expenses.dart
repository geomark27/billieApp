/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: expenses
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/expenses/models/expense.dart';

class ExpensesAPI extends BaseAPI<Expense> {
  ExpensesAPI() : super('expenses');

  @override
  Expense fromJson(Map<String, dynamic> json) => Expense.fromJson(json);

  static Future<Data<Expense>> get(String? token) async {
    final api = ExpensesAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(Expense expense, String? token) async {
    final api = ExpensesAPI();
    return await api.POST(
      data: expense,
      token: token,
    );
  }

  static Future<Message> update(int id, Expense expense, String? token) async {
    final api = ExpensesAPI();
    return await api.PUT(
      id: id,
      data: expense,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = ExpensesAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
