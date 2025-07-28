/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: supplier_payment
*/

import 'package:salepro/models/mappable.dart';

class SupplierPaymentReport implements Mappable {
  final String? date;
  final String? paymentReference;
  final String? purchaseReference;
  final String? amount;
  final String? paidMethod;

  SupplierPaymentReport({
    this.date,
    this.paymentReference,
    this.purchaseReference,
    this.amount,
    this.paidMethod,
  });

  factory SupplierPaymentReport.fromJson(Map json) {
    return SupplierPaymentReport(
      date: json['date'],
      paymentReference: json['reference_no'],
      purchaseReference: json['purchase_reference'],
      amount: json['amount'],
      paidMethod: json['paying_method'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      SupplierPaymentReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reference_no': paymentReference,
      'purchase_reference': purchaseReference,
      'amount': amount,
      'paying_method': paidMethod,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
