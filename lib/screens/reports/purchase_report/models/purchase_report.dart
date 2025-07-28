/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: purchase_report
*/

import 'package:salepro/models/mappable.dart';

class PurchaseReport implements Mappable {
  final String? startDate;
  final String? endDate;
  final String? warehouseId;

  final int? id;
  final String? name;
  final String? code;
  final String? category;
  final String? purchasedAmount;
  final String? purchasedQty;
  final String? inStock;

  PurchaseReport({
    this.startDate,
    this.endDate,
    this.warehouseId,
    this.id,
    this.name,
    this.code,
    this.category,
    this.purchasedAmount,
    this.purchasedQty,
    this.inStock,
  });

  factory PurchaseReport.fromJson(Map json) {
    return PurchaseReport(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      category: json['category'],
      purchasedAmount: double.tryParse(json['purchased_amount'].toString())
              ?.toStringAsFixed(2) ??
          "",
      purchasedQty: json['purchased_qty'].toString(),
      inStock: json['in_stock'].toString(),
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => PurchaseReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'category': category,
      'purchased_amount': purchasedAmount,
      'purchased_qty': purchasedQty,
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
