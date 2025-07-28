/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: short_payment
*/

import 'package:salepro/models/mappable.dart';

class ShortPayment implements Mappable {
  final int id;
  final String date;
  final String referenceNo;
  final String amount;
  final String paidBy;

  ShortPayment({
    required this.id,
    required this.date,
    required this.referenceNo,
    required this.paidBy,
    required this.amount,
  });

  factory ShortPayment.fromJson(Map json) {
    return ShortPayment(
      id: json['id'],
      date: json['date'] ?? "",
      referenceNo: json['reference_no'] ?? "",
      paidBy: json['paid_by'] ?? "",
      amount: json['amount'] ?? "",
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => ShortPayment.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'reference_no': referenceNo,
      'paidBy': paidBy,
      'amount': amount,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
