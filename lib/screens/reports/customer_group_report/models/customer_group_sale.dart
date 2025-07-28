/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: customer_group_sale
*/

import 'package:salepro/models/mappable.dart';

class CustomerGroupSaleReport implements Mappable {
  final String? date;
  final String? referenceNo;
  final String? warehouse;
  final String? product;
  final String? customer;
  final String? grandTotal;
  final String? paid;
  final String? due;
  final String? status;

  CustomerGroupSaleReport({
    this.date,
    this.referenceNo,
    this.warehouse,
    this.product,
    this.customer,
    this.grandTotal,
    this.paid,
    this.due,
    this.status,
  });

  factory CustomerGroupSaleReport.fromJson(Map json) {
    return CustomerGroupSaleReport(
      date: json['date'],
      referenceNo: json['reference_no'],
      warehouse: json['warehouse'],
      product: json['product'],
      customer: json['customer'],
      grandTotal: json['grand_total'],
      paid: json['paid'],
      due: json['due'],
      status: json['sale_status'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      CustomerGroupSaleReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'reference_no': referenceNo,
      'warehouse': warehouse,
      'product': product,
      'customer': customer,
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
