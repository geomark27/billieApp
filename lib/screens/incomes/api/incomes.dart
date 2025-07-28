/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: incomes
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/incomes/models/income.dart';

class IncomesAPI extends BaseAPI<Income> {
  IncomesAPI() : super('incomes');

  @override
  Income fromJson(Map<String, dynamic> json) => Income.fromJson(json);

  static Future<Data<Income>> get(String? token) async {
    final api = IncomesAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(Income income, String? token) async {
    final api = IncomesAPI();
    return await api.POST(
      data: income,
      token: token,
    );
  }

  static Future<Message> update(int id, Income income, String? token) async {
    final api = IncomesAPI();
    return await api.PUT(
      id: id,
      data: income,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = IncomesAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
