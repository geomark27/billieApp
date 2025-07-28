/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: money_transfer
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/accounting/models/account.dart';

class MoneyTransfer implements Mappable {
  final int id;
  final String date;
  final String referenceNo;
  final Account? fromAccount;
  final Account? toAccount;
  final double amount;

  MoneyTransfer({
    required this.id,
    required this.referenceNo,
    required this.date,
    this.fromAccount,
    this.toAccount,
    required this.amount,
  });

  factory MoneyTransfer.fromJson(Map json) {
    return MoneyTransfer(
      id: json["id"],
      referenceNo: json["reference_no"],
      amount: double.tryParse(json["amount"].toString()) ?? 0,
      fromAccount: json['from_account_id'] != null
          ? Account.fromJson(
              json['from_account_id'],
            )
          : null,
      toAccount: json['to_account_id'] != null
          ? Account.fromJson(
              json['to_account_id'],
            )
          : null,
      date: json['date'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => MoneyTransfer.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'from_account_id': fromAccount?.toMap(),
      'to_account_id': toAccount?.toMap(),
      'reference_no': referenceNo,
      'amount': amount.toStringAsFixed(2),
      'date': date,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'from_account_id': fromAccount?.id.toString(),
      'to_account_id': toAccount?.id.toString(),
      'amount': amount.toStringAsFixed(2),
    };
  }
}
