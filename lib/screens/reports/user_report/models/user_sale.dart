/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: user_sale
*/

import 'package:salepro/models/mappable.dart';

class UserSaleReport implements Mappable {
  final String? date;
  final String? referenceNo;
  final String? customer;
  final String? warehouse;
  final String? product;
  final String? totalCost;
  final String? grandTotal;
  final String? paid;
  final String? due;
  final String? status;

  UserSaleReport({
    this.date,
    this.referenceNo,
    this.customer,
    this.warehouse,
    this.product,
    this.totalCost,
    this.grandTotal,
    this.paid,
    this.due,
    this.status,
  });

  factory UserSaleReport.fromJson(Map json) {
    return UserSaleReport(
      date: json['date'],
      referenceNo: json['reference_no'],
      customer: json['customer'],
      warehouse: json['warehouse'],
      product: json['product'],
      totalCost: json['total_cost'],
      grandTotal: json['grand_total'],
      paid: json['paid'],
      due: json['due'],
      status: json['sale_status'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => UserSaleReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reference_no': referenceNo,
      'customer': customer,
      'warehouse': warehouse,
      'product': product,
      'total_cost': totalCost,
      'grand_total': grandTotal,
      'paid': paid,
      'due': due,
      'sale_status': status,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
