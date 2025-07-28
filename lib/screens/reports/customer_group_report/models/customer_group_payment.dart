/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_group_payment
*/

import 'package:salepro/models/mappable.dart';

class CustomerGroupPaymentReport implements Mappable {
  final String? date;
  final String? reference;
  final String? saleReference;
  final String? customer;
  final String? amount;
  final String? payingMethod;

  CustomerGroupPaymentReport({
    this.date,
    this.reference,
    this.saleReference,
    this.customer,
    this.amount,
    this.payingMethod,
  });

  factory CustomerGroupPaymentReport.fromJson(Map json) {
    return CustomerGroupPaymentReport(
      date: json['date'],
      reference: json['reference_no'],
      saleReference: json['sale_reference'],
      customer: json['customer'],
      amount: json['amount'],
      payingMethod: json['paying_method'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      CustomerGroupPaymentReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reference_no': reference,
      'sale_reference': saleReference,
      'customer': customer,
      'amount': amount,
      'paying_method': payingMethod,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
