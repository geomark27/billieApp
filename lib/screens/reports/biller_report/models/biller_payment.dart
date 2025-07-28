/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: biller_payment
*/

import 'package:salepro/models/mappable.dart';

class BillerPaymentReport implements Mappable {
  final String? date;
  final String? paymentReference;
  final String? amount;
  final String? paidMethod;

  BillerPaymentReport({
    this.date,
    this.paymentReference,
    this.amount,
    this.paidMethod,
  });

  factory BillerPaymentReport.fromJson(Map json) {
    return BillerPaymentReport(
      date: json['date'],
      paymentReference: json['reference_no'],
      amount: json['amount'],
      paidMethod: json['paying_method'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      BillerPaymentReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reference_no': paymentReference,
      'amount': amount,
      'paying_method': paidMethod,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
