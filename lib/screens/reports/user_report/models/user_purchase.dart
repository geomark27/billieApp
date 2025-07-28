/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: user_purchase
*/

import 'package:salepro/models/mappable.dart';

class UserPurchaseReport implements Mappable {
  final String? date;
  final String? referenceNo;
  final String? warehouse;
  final String? product;
  final String? supplier;
  final String? grandTotal;
  final String? paid;
  final String? balance;
  final String? status;

  UserPurchaseReport({
    this.date,
    this.referenceNo,
    this.warehouse,
    this.product,
    this.supplier,
    this.grandTotal,
    this.paid,
    this.balance,
    this.status,
  });

  factory UserPurchaseReport.fromJson(Map json) {
    return UserPurchaseReport(
      date: json['date'],
      referenceNo: json['reference_no'],
      warehouse: json['warehouse'],
      supplier: json['supplier'],
      product: json['product'],
      grandTotal: json['grand_total'],
      paid: json['paid'],
      balance: json['balance'],
      status: json['status'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      UserPurchaseReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reference_no': referenceNo,
      'warehouse': warehouse,
      'supplier': supplier,
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
