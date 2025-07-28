/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: purchase_return
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/people/suppliers/models/supplier.dart';
import 'package:salepro/screens/people/customers/models/customer.dart';
import 'package:salepro/screens/products/models/product.dart';
import 'package:salepro/screens/settings/warehouse/models/warehouse.dart';

class PurchaseReturn implements Mappable {
  final int id;
  final String? date;
  final String referenceNo;
  final String? saleReference;
  final String? grandTotal;
  final Warehouse? warehouse;
  final Supplier? supplier;
  final Customer? customer;
  final List<Product>? products;

  PurchaseReturn({
    required this.id,
    this.date,
    required this.referenceNo,
    this.saleReference,
    this.grandTotal,
    this.warehouse,
    this.supplier,
    this.customer,
    this.products,
  });

  factory PurchaseReturn.fromJson(Map json) {
    return PurchaseReturn(
      id: json['id'],
      date: json['date'] ?? "",
      referenceNo: json['reference_no'] ?? "",
      saleReference: json['sale_reference'] ?? "",
      grandTotal: (json['grand_total'] ?? 0).toString(),
      supplier: json['supplier'] != null
          ? Supplier.fromJson(
              json['supplier'],
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
  Mappable fromJson(Map<String, dynamic> json) => PurchaseReturn.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'reference_no': referenceNo,
      'sale_reference': saleReference,
      'supplier': supplier?.toMap(),
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
