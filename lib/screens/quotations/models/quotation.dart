/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: quotation
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/people/biller/models/biller.dart';
import 'package:salepro/screens/people/customers/models/customer.dart';
import 'package:salepro/screens/people/suppliers/models/supplier.dart';
import 'package:salepro/screens/products/models/short_product.dart';
import 'package:salepro/screens/settings/warehouse/models/warehouse.dart';

class Quotation implements Mappable {
  final int id;
  final String date;
  final String referenceNo;
  final Warehouse? warehouse;
  final Biller? biller;
  final Customer? customer;
  final Supplier? supplier;
  final String status;
  final String grandTotal;
  final List<ShortProduct> products;

  Quotation({
    required this.id,
    required this.date,
    required this.referenceNo,
    required this.warehouse,
    required this.biller,
    required this.customer,
    required this.supplier,
    required this.status,
    required this.grandTotal,
    required this.products,
  });

  factory Quotation.fromJson(Map json) {
    return Quotation(
      id: json['id'],
      date: json['date'] ?? "",
      referenceNo: json['reference_no'] ?? "",
      status: json['status'] ?? "",
      grandTotal: json['grand_total'] ?? "",
      warehouse: json['warehouse'] != null
          ? Warehouse.fromJson(json['warehouse'])
          : null,
      biller: json['billler'] != null ? Biller.fromJson(json['biller']) : null,
      customer:
          json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      supplier:
          json['supplier'] != null ? Supplier.fromJson(json['supplier']) : null,
      products: json['products'] != null
          ? (json['products'] as List)
              .map((p) => ShortProduct.fromJson(p))
              .toList()
          : [],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => Quotation.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'reference_no': referenceNo,
      'warehouse': warehouse?.toMap(),
      'biller': biller?.toMap(),
      'customer': customer?.toMap(),
      'supplier': supplier?.toMap(),
      'status': status,
      'grandTotal': grandTotal,
      'products': products.map((p) => p.toMap()).toList(),
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
