/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: account
*/

import 'package:salepro/models/mappable.dart';

class Account implements Mappable {
  final int id;
  final String accountNo;
  final String name;
  final double initialBalance;
  final String? note;
  final bool? isDefault;

  Account({
    required this.id,
    required this.accountNo,
    required this.name,
    required this.initialBalance,
    this.note,
    required this.isDefault,
  });

  factory Account.fromJson(Map json) {
    return Account(
      id: json['id'],
      accountNo: json['account_no'],
      name: json['name'],
      initialBalance:
          double.parse(json['initial_balance'].toString().replaceAll(',', '')),
      note: json['note'],
      isDefault: json['is_default'] == 1,
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => Account.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'account_no': accountNo,
      'name': name,
      'initial_balance': initialBalance,
      'note': note,
      'is_default': isDefault,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'account_no': accountNo,
      'name': name,
      'initial_balance': initialBalance.toStringAsFixed(2),
      'note': note,
    };
  }
}
