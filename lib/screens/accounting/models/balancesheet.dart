/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: balancesheet
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/accounting/models/account.dart';

class BalanceSheet implements Mappable {
  final Account? account;
  final double credit;
  final double debit;
  final double balance;

  BalanceSheet({
    this.account,
    required this.credit,
    required this.debit,
    required this.balance,
  });

  factory BalanceSheet.fromJson(Map json) {
    return BalanceSheet(
      account:
          json['account'] != null ? Account.fromJson(json['account']) : null,
      credit:
          double.tryParse(json['credit'].toString().replaceAll(',', '')) ?? 0,
      debit: double.tryParse(json['debit'].toString().replaceAll(',', '')) ?? 0,
      balance:
          double.tryParse(json['balance'].toString().replaceAll(',', '')) ?? 0,
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => BalanceSheet.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'account': account?.toMap(),
      'credit': credit.toStringAsFixed(2),
      'debit': debit.toStringAsFixed(2),
      'balance': balance.toStringAsFixed(2),
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
