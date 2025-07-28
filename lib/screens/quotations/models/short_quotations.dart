/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: short_quotations
*/

import 'package:salepro/models/mappable.dart';

class ShortQuotation implements Mappable {
  final int id;
  final String date;
  final String referenceNo;
  final String customer;
  final String status;
  final String grandTotal;

  ShortQuotation({
    required this.id,
    required this.date,
    required this.referenceNo,
    required this.customer,
    required this.status,
    required this.grandTotal,
  });

  factory ShortQuotation.fromJson(Map json) {
    return ShortQuotation(
      id: json['id'],
      date: json['date'] ?? "",
      referenceNo: json['reference_no'] ?? "",
      customer: json['customer'] ?? "",
      status: json['status'] ?? "",
      grandTotal: json['grand_total'] ?? "",
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => ShortQuotation.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'reference_no': referenceNo,
      'customer': customer,
      'status': status,
      'grandTotal': grandTotal,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
