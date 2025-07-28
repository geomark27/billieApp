/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: supplier_purchase
*/

import 'package:salepro/models/mappable.dart';

class SupplierPurchaseReport implements Mappable {
  final String? date;
  final String? referenceNo;
  final String? warehouse;
  final String? product;
  final String? grandTotal;
  final String? paid;
  final String? balance;
  final String? status;

  SupplierPurchaseReport({
    this.date,
    this.referenceNo,
    this.warehouse,
    this.product,
    this.grandTotal,
    this.paid,
    this.balance,
    this.status,
  });

  factory SupplierPurchaseReport.fromJson(Map json) {
    return SupplierPurchaseReport(
      date: json['date'],
      referenceNo: json['reference_no'],
      warehouse: json['warehouse'],
      product: json['product'],
      grandTotal: json['grand_total'],
      paid: json['paid'],
      balance: json['balance'],
      status: json['status'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      SupplierPurchaseReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reference_no': referenceNo,
      'warehouse': warehouse,
      'product': product,
      'grand_total': grandTotal,
      'paid': paid,
      'balance': balance,
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
