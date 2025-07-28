/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: user_quotation
*/

import 'package:salepro/models/mappable.dart';

class UserQuotationReport implements Mappable {
  final String? date;
  final String? referenceNo;
  final String? warehouse;
  final String? customer;
  final String? product;
  final String? grandTotal;
  final String? status;

  UserQuotationReport({
    this.date,
    this.referenceNo,
    this.warehouse,
    this.customer,
    this.product,
    this.grandTotal,
    this.status,
  });

  factory UserQuotationReport.fromJson(Map json) {
    return UserQuotationReport(
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
      UserQuotationReport.fromJson(json);

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
