/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: balancesheets
*/

import 'package:salepro/api/base.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/accounting/models/balancesheet.dart';

class BalanceSheetsAPI extends BaseAPI<BalanceSheet> {
  BalanceSheetsAPI() : super('balancesheet');

  @override
  BalanceSheet fromJson(Map<String, dynamic> json) =>
      BalanceSheet.fromJson(json);

  static Future<Data<BalanceSheet>> get(String? token) async {
    final api = BalanceSheetsAPI();
    return await api.GET(token: token);
  }
}
