/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: short_purchase
*/

import 'package:salepro/models/mappable.dart';

class ShortPurchase implements Mappable {
  final int id;
  final String date;
  final String referenceNo;
  final String supplier;
  final String status;
  final String grandTotal;

  ShortPurchase({
    required this.id,
    required this.date,
    required this.referenceNo,
    required this.supplier,
    required this.status,
    required this.grandTotal,
  });

  factory ShortPurchase.fromJson(Map json) {
    return ShortPurchase(
      id: json['id'],
      date: json['date'] ?? "",
      referenceNo: json['reference_no'] ?? "",
      supplier: json['supplier'] ?? "",
      status: json['status'] ?? "",
      grandTotal: json['grand_total'] ?? "",
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => ShortPurchase.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'reference_no': referenceNo,
      'supplier': supplier,
      'status': status,
      'grandTotal': grandTotal,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
