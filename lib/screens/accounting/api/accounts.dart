/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: accounts
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/models/message.dart';
import 'package:salepro/screens/accounting/models/account.dart';

class AccountsAPI extends BaseAPI<Account> {
  AccountsAPI() : super('accounts');

  @override
  Account fromJson(Map<String, dynamic> json) => Account.fromJson(json);

  static Future<Data<Account>> get(String? token) async {
    final api = AccountsAPI();
    return await api.GET(token: token);
  }

  static Future<Message> create(Account account, String? token) async {
    final api = AccountsAPI();
    return await api.POST(
      data: account,
      token: token,
    );
  }

  static Future<Message> update(int id, Account account, String? token) async {
    final api = AccountsAPI();
    return await api.PUT(
      id: id,
      data: account,
      token: token,
    );
  }

  static Future<Message> delete(int id, String? token) async {
    final api = AccountsAPI();
    return await api.DELETE(
      id: id,
      token: token,
    );
  }
}
