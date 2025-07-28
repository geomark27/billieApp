/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: supplier_return
*/

import 'package:salepro/models/mappable.dart';

class SupplierReturnReport implements Mappable {
  final String? date;
  final String? referenceNo;
  final String? warehouse;
  final String? product;
  final String? grandTotal;

  SupplierReturnReport({
    this.date,
    this.referenceNo,
    this.warehouse,
    this.product,
    this.grandTotal,
  });

  factory SupplierReturnReport.fromJson(Map json) {
    return SupplierReturnReport(
      date: json['date'],
      referenceNo: json['reference_no'],
      warehouse: json['warehouse'],
      product: json['product'],
      grandTotal: json['grand_total'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      SupplierReturnReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reference_no': referenceNo,
      'warehouse': warehouse,
      'product': product,
      'grand_total': grandTotal,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
