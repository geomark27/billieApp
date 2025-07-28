/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: transfer
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/products/models/short_product.dart';
import 'package:salepro/screens/settings/warehouse/models/warehouse.dart';

class Transfer implements Mappable {
  final int id;
  final String date;
  final String referenceNo;
  final Warehouse? from;
  final Warehouse? to;
  final String productCost;
  final String productTax;
  final String grandTotal;
  final String status;
  final String emailSent;
  final List<ShortProduct> products;

  Transfer({
    required this.id,
    required this.date,
    required this.referenceNo,
    this.from,
    this.to,
    required this.productCost,
    required this.productTax,
    required this.status,
    required this.grandTotal,
    required this.emailSent,
    required this.products,
  });

  factory Transfer.fromJson(Map json) {
    return Transfer(
      id: json['id'],
      date: json['date'] ?? "",
      referenceNo: json['reference_no'] ?? "",
      from: json['from_warehouse'] != null
          ? Warehouse.fromJson(json['from_warehouse'])
          : null,
      to: json['to_warehouse'] != null
          ? Warehouse.fromJson(json['to_warehouse'])
          : null,
      productCost: (double.tryParse(json['product_cost'].toString()) ?? 0)
          .toStringAsFixed(2),
      productTax: (double.tryParse(json['product_tax'].toString()) ?? 0)
          .toStringAsFixed(2),
      grandTotal: (double.tryParse(json['grand_total'].toString()) ?? 0)
          .toStringAsFixed(2),
      status: json['status'] ?? "",
      emailSent: json['email_sent'] ?? "",
      products: json['products'] != null
          ? (json['products'] as List)
              .map((p) => ShortProduct.fromJson(p))
              .toList()
          : [],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => Transfer.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": date,
      "reference_no": referenceNo,
      "from_warehouse": from?.toMap(),
      "to_warehouse": to?.toMap(),
      "product_cost": productCost,
      "product_tax": productTax,
      "grand_total": grandTotal,
      "status": status,
      "email_sent": emailSent,
      "products": products.map((p) => p.toMap()),
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      "id": id,
      "date": date,
      "reference_no": referenceNo,
      "from_warehouse": from?.id,
      "to_warehouse": to?.id,
      "product_cost": productCost,
      "product_tax": productTax,
      "grand_total": grandTotal,
      "status": status,
      "email_sent": emailSent,
      "products": products.map((p) => p.id),
    };
  }
}
