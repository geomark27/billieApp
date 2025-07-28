/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: sale_report
*/

import 'package:salepro/models/mappable.dart';

class SaleReport implements Mappable {
  final String? startDate;
  final String? endDate;
  final String? warehouseId;

  final int? id;
  final String? name;
  final String? code;
  final String? category;
  final String? soldAmount;
  final String? soldQty;
  final String? inStock;

  SaleReport({
    this.startDate,
    this.endDate,
    this.warehouseId,
    this.id,
    this.name,
    this.code,
    this.category,
    this.soldAmount,
    this.soldQty,
    this.inStock,
  });

  factory SaleReport.fromJson(Map json) {
    return SaleReport(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      category: json['category'],
      soldAmount: json['sold_amount'].toString(),
      soldQty: json['sold_qty'].toString(),
      inStock: json['in_stock'].toString(),
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => SaleReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'category': category,
      'sold_amount': soldAmount,
      'sold_qty': soldQty,
      'in_stock': inStock,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'start_date': startDate,
      'end_date': endDate,
      'warehouse_id': warehouseId,
    };
  }
}
