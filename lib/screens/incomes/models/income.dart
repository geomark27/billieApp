/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: income
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/accounting/models/account.dart';
import 'package:salepro/screens/incomes/categories/models/income_category.dart';
import 'package:salepro/screens/settings/warehouse/models/warehouse.dart';

class Income implements Mappable {
  final int id;
  final String date;
  final String referenceNo;
  final Warehouse? warehouse;
  final IncomeCategory? category;
  final String amount;
  final String? note;
  final Account? account;

  Income({
    required this.id,
    required this.date,
    required this.referenceNo,
    this.warehouse,
    this.category,
    required this.amount,
    this.note,
    this.account,
  });

  factory Income.fromJson(Map json) {
    return Income(
      id: json['id'],
      date: json['date'],
      referenceNo: json['reference_no'],
      warehouse: json['warehouse'] != null
          ? Warehouse.fromJson(json['warehouse'])
          : null,
      category: json['category'] != null
          ? IncomeCategory.fromJson(json['category'])
          : null,
      amount: json['amount'],
      note: json['note'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => Income.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'reference_no': referenceNo,
      'warehouse': warehouse?.toMap(),
      'category': category?.toMap(),
      'amount': amount,
      'note': note,
      'account': account?.toMap(),
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'created_at': date,
      'warehouse_id': warehouse?.id,
      'income_category_id': category?.id,
      'amount': amount,
      'note': note,
      'account_id': account?.id,
    };
  }
}
