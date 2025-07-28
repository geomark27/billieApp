/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: short_product
*/

import 'package:salepro/models/mappable.dart';

class ShortProduct implements Mappable {
  final int id;
  final String name;
  final String code;
  final String image;
  final String qty;
  final String grandTotal;
  final String unit;
  final String tax;
  final String taxRate;
  final String total;
  final String batch;

  ShortProduct({
    required this.id,
    required this.name,
    required this.code,
    required this.image,
    required this.qty,
    required this.grandTotal,
    required this.unit,
    required this.tax,
    required this.taxRate,
    required this.total,
    required this.batch,
  });

  factory ShortProduct.fromJson(Map json) {
    return ShortProduct(
      id: json['id'] ?? 0,
      name: json['name'],
      code: json['code'] ?? "",
      image: json['image'] ?? "",
      qty: json['qty'].toString(),
      grandTotal: json['grand_total'].toString(),
      unit: json['unit'] ?? "pc",
      tax: double.tryParse(json['tax'].toString())?.toStringAsFixed(2) ?? "0",
      taxRate:
          double.tryParse(json['tax_rate'].toString())?.toStringAsFixed(2) ??
              "0",
      total: double.tryParse(json['tax_rate'].toString())?.toStringAsFixed(2) ??
          "0",
      batch: json['batch'] ?? "N/A",
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => ShortProduct.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'image': image,
      'qty': qty,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
