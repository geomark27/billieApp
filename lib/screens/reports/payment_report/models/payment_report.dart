/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: payment_report
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/models/user.dart';

class PaymentReport implements Mappable {
  final String? startDate;
  final String? endDate;

  final int? id;
  final String? createdAt;
  final String? paymentReference;
  final String? saleReference;
  final String? purchaseReference;
  final String? payingMethod;
  final String? amount;
  final User? user;

  PaymentReport({
    this.startDate,
    this.endDate,
    this.id,
    this.createdAt,
    this.paymentReference,
    this.saleReference,
    this.purchaseReference,
    this.payingMethod,
    this.amount,
    this.user,
  });

  factory PaymentReport.fromJson(Map json) {
    return PaymentReport(
      id: json['id'],
      createdAt: json['created_at'],
      paymentReference: json['payment_reference'],
      saleReference: json['sale_reference'],
      purchaseReference: json['purchase_reference'],
      payingMethod: json['paying_method'],
      amount:
          double.tryParse(json['amount'].toString())?.toStringAsFixed(2) ?? "0",
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => PaymentReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'payment_reference': paymentReference,
      'sale_reference': saleReference,
      'purchase_reference': purchaseReference,
      'paying_method': payingMethod,
      'amount': amount,
      'user': user?.toMap()
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}
