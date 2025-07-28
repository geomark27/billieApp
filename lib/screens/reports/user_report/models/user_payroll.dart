/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: user_payroll
*/

import 'package:salepro/models/mappable.dart';

class UserPayrollReport implements Mappable {
  final String? date;
  final String? paymentReference;
  final String? employee;
  final String? amount;
  final String? paidMethod;

  UserPayrollReport({
    this.date,
    this.paymentReference,
    this.employee,
    this.amount,
    this.paidMethod,
  });

  factory UserPayrollReport.fromJson(Map json) {
    return UserPayrollReport(
      date: json['date'],
      paymentReference: json['reference_no'],
      employee: json['employee'],
      amount: json['amount'],
      paidMethod: json['paying_method'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      UserPayrollReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reference_no': paymentReference,
      'employee': employee,
      'amount': amount,
      'paying_method': paidMethod,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
