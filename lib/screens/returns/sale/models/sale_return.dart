/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: sale_return
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/people/biller/models/biller.dart';
import 'package:salepro/screens/people/customers/models/customer.dart';
import 'package:salepro/screens/products/models/product.dart';
import 'package:salepro/screens/settings/warehouse/models/warehouse.dart';

class SaleReturn implements Mappable {
  final int id;
  final String? date;
  final String referenceNo;
  final String? saleReference;
  final String? grandTotal;
  final Warehouse? warehouse;
  final Biller? biller;
  final Customer? customer;
  final List<Product>? products;

  SaleReturn({
    required this.id,
    this.date,
    required this.referenceNo,
    this.saleReference,
    this.grandTotal,
    this.warehouse,
    this.biller,
    this.customer,
    this.products,
  });

  factory SaleReturn.fromJson(Map json) {
    return SaleReturn(
      id: json['id'],
      date: json['date'] ?? "",
      referenceNo: json['reference_no'] ?? "",
      saleReference: json['sale_reference'] ?? "",
      grandTotal: (json['grand_total'] ?? 0).toString(),
      biller: json['biller'] != null
          ? Biller.fromJson(
              json['biller'],
            )
          : null,
      customer: json['customer'] != null
          ? Customer.fromJson(
              json['customer'],
            )
          : null,
      warehouse: json['warehouse'] != null
          ? Warehouse.fromJson(
              json['warehouse'],
            )
          : null,
      products: json['products'] != null
          ? (json['products'] as List).map((p) => Product.fromJson(p)).toList()
          : [],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => SaleReturn.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'reference_no': referenceNo,
      'sale_reference': saleReference,
      'biller': biller?.toMap(),
      'customer': customer?.toMap(),
      'warehouse': warehouse?.toMap(),
      'grand_total': grandTotal,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'sale_reference': saleReference,
    };
  }
}
