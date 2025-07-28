/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_payment
*/

import 'package:salepro/models/mappable.dart';

class CustomerPaymentReport implements Mappable {
  final String? date;
  final String? reference;
  final String? saleReference;
  final String? amount;
  final String? payingMethod;

  CustomerPaymentReport({
    this.date,
    this.reference,
    this.saleReference,
    this.amount,
    this.payingMethod,
  });

  factory CustomerPaymentReport.fromJson(Map json) {
    return CustomerPaymentReport(
      date: json['date'],
      reference: json['reference_no'],
      saleReference: json['sale_reference'],
      amount: json['amount'],
      payingMethod: json['paying_method'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      CustomerPaymentReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reference_no': reference,
      'sale_reference': saleReference,
      'amount': amount,
      'paying_method': payingMethod,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
