/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: account_statements
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/accounting/models/account_statement.dart';

class AccountStatementsAPI extends BaseAPI<AccountStatement> {
  AccountStatementsAPI() : super('account-statement');

  @override
  AccountStatement fromJson(Map<String, dynamic> json) =>
      AccountStatement.fromJson(json);

  static Future<Data<AccountStatement>> get(String? token) async {
    final api = AccountStatementsAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(
      AccountStatement accountStatement, String? token) async {
    final api = AccountStatementsAPI();
    return await api.POST(
      data: accountStatement,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = AccountStatementsAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
