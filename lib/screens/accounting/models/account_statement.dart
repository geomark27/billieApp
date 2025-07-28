/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: account_statement
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/accounting/models/account.dart';

class AccountStatement implements Mappable {
  final Account? account;
  final String? type;
  final String? startDate;
  final String? endDate;
  final String? date;
  final String? referenceNo;
  final String? relatedTransaction;
  final String? credit;
  final String? debit;
  final String? balance;

  AccountStatement({
    this.account,
    this.type,
    this.startDate,
    this.endDate,
    this.date,
    this.referenceNo,
    this.relatedTransaction,
    this.credit,
    this.debit,
    this.balance,
  });

  factory AccountStatement.fromJson(Map json) {
    return AccountStatement(
      date: json['date'],
      referenceNo: json['reference_no'],
      relatedTransaction: json['related_transaction'],
      credit: json['credit'],
      debit: json['debit'],
      balance: json['balance'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      AccountStatement.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reference_no': referenceNo,
      'related_transaction': relatedTransaction,
      'credit': credit,
      'debit': debit,
      'balance': balance,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'account_id': account?.id.toString(),
      'type': type,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}
