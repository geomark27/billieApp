/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: product_report
*/

import 'package:salepro/models/mappable.dart';

class ProductReport implements Mappable {
  final String? startDate;
  final String? endDate;
  final String? warehouseId;

  final int? id;
  final String? imeiNumbers;
  final String? name;
  final String? code;
  final String? category;
  final String? purchasedAmount;
  final String? purchasedQty;
  final String? soldAmount;
  final String? soldQty;
  final String? returnedAmount;
  final String? returnedQty;
  final String? purchaseReturnedAmount;
  final String? purchaseReturnedQty;
  final String? profit;
  final String? inStock;
  final String? stockWorth;

  ProductReport({
    this.startDate,
    this.endDate,
    this.warehouseId,
    this.id,
    this.imeiNumbers,
    this.name,
    this.code,
    this.category,
    this.purchasedAmount,
    this.purchasedQty,
    this.soldAmount,
    this.soldQty,
    this.returnedAmount,
    this.returnedQty,
    this.purchaseReturnedAmount,
    this.purchaseReturnedQty,
    this.profit,
    this.inStock,
    this.stockWorth,
  });

  factory ProductReport.fromJson(Map json) {
    return ProductReport(
      id: json['id'],
      imeiNumbers: json['imei_numbers'],
      name: json['name'],
      code: json['code'],
      category: json['category'],
      purchasedAmount: double.tryParse(json['purchased_amount'].toString())
              ?.toStringAsFixed(2) ??
          "",
      purchasedQty: json['purchased_qty'].toString(),
      soldAmount:
          double.tryParse(json['sold_amount'].toString())?.toStringAsFixed(2) ??
              "",
      soldQty: json['sold_qty'].toString(),
      returnedAmount: double.tryParse(json['returned_amount'].toString())
              ?.toStringAsFixed(2) ??
          "",
      returnedQty: json['returned_qty'].toString(),
      purchaseReturnedAmount:
          double.tryParse(json['purchase_returned_amount'].toString())
                  ?.toStringAsFixed(2) ??
              "",
      purchaseReturnedQty: json['purchase_returned_qty'].toString(),
      profit: json['profit'].toString(),
      inStock: json['in_stock'].toString(),
      stockWorth: json['stock_worth'],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => ProductReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imei_numbers': imeiNumbers,
      'name': name,
      'code': code,
      'category': category,
      'purchased_amount': purchasedAmount,
      'purchased_qty': purchasedQty,
      'sold_amount': soldAmount,
      'sold_qty': soldQty,
      'returned_amount': returnedAmount,
      'returned_qty': returnedQty,
      'purchase_returned_amount': purchaseReturnedAmount,
      'purchase_returned_qty': purchaseReturnedQty,
      'profit': profit,
      'in_stock': inStock,
      'stock_worth': stockWorth,
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
