/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: user_expense
*/

import 'package:salepro/models/mappable.dart';

class UserExpenseReport implements Mappable {
  final String? date;
  final String? referenceNo;
  final String? warehouse;
  final String? category;
  final String? amount;
  final String? note;

  UserExpenseReport({
    this.date,
    this.referenceNo,
    this.warehouse,
    this.category,
    this.amount,
    this.note,
  });

  factory UserExpenseReport.fromJson(Map json) {
    return UserExpenseReport(
      date: json['date'],
      referenceNo: json['reference_no'],
      warehouse: json['warehouse'],
      category: json['category'],
      amount: json['amount'],
      note: json['grand_total'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      UserExpenseReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reference_no': referenceNo,
      'warehouse': warehouse,
      'category': category,
      'amount': amount,
      'grand_total': note,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
