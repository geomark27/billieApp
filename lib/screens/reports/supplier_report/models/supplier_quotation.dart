/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: supplier_quotation
*/

import 'package:salepro/models/mappable.dart';

class SupplierQuotationReport implements Mappable {
  final String? date;
  final String? referenceNo;
  final String? warehouse;
  final String? customer;
  final String? product;
  final String? grandTotal;
  final String? status;

  SupplierQuotationReport({
    this.date,
    this.referenceNo,
    this.warehouse,
    this.customer,
    this.product,
    this.grandTotal,
    this.status,
  });

  factory SupplierQuotationReport.fromJson(Map json) {
    return SupplierQuotationReport(
      date: json['date'],
      referenceNo: json['reference_no'],
      warehouse: json['warehouse'],
      customer: json['customer'],
      product: json['product'],
      grandTotal: json['grand_total'],
      status: json['status'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      SupplierQuotationReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reference_no': referenceNo,
      'warehouse': warehouse,
      'customer': customer,
      'product': product,
      'grand_total': grandTotal,
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
