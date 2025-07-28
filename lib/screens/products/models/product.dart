/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: product
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/products/categories/models/product_category.dart';
import 'package:salepro/screens/settings/brands/models/brand.dart';
import 'package:salepro/screens/settings/taxes/models/tax.dart';
import 'package:salepro/screens/settings/units/models/unit.dart';
import 'package:salepro/screens/settings/warehouse/models/warehouse.dart';

class Product implements Mappable {
  final int id;
  final String type;
  final String name;
  final String barcodeSymbology;
  final String? image;
  final String code;
  final Brand? brand;
  final ProductCategory? category;
  final int quantity;
  final Unit? unit;
  final Unit? saleUnit;
  final Unit? purchaseUnit;
  final String cost;
  final String price;
  final String discount;
  final String stockWorth;
  final Tax? taxRate;
  final List<Warehouse>? warehouse;
  final String? costTax;
  final String? taxMethod;
  final String? costSubtotal;

  final String? saleBatch;
  final int? saleQty;
  final int? saleReturnQty;
  final double? saleNetUnitPrice;
  final double? saleTax;
  final double? saleTaxRate;
  final double? saleDiscount;
  final double? saleTotal;

  Product({
    required this.id,
    required this.name,
    required this.type,
    required this.barcodeSymbology,
    this.image,
    required this.code,
    this.brand,
    this.category,
    this.warehouse,
    required this.quantity,
    this.unit,
    this.saleUnit,
    this.purchaseUnit,
    this.taxRate,
    this.costTax,
    this.taxMethod,
    this.costSubtotal,
    required this.cost,
    required this.price,
    required this.discount,
    required this.stockWorth,
    this.saleBatch,
    this.saleQty,
    this.saleReturnQty,
    this.saleNetUnitPrice,
    this.saleTax,
    this.saleTaxRate,
    this.saleDiscount,
    this.saleTotal,
  });

  factory Product.fromJson(Map json) {
    final cost =
        double.tryParse(json['cost'].toString().replaceAll(",", "")) ?? 0;
    final quantity = int.tryParse((json['quantity'] ?? "1").toString()) ?? 0;
    final taxRate =
        json['tax'] == null ? 0 : (Tax.fromJson(json['tax']).rate / 100);
    final discount =
        double.tryParse(json['discount'].toString().replaceAll(",", "")) ?? 0;

    return Product(
      id: json['id'],
      type: "",
      barcodeSymbology: "",
      name: json['name'],
      image: json['image'],
      code: json['code'],
      quantity: int.tryParse(json['quantity'].toString()) ?? 1,
      cost: cost.toStringAsFixed(2),
      price: json['price'].toString().replaceAll(',', ''),
      stockWorth: json['stock_worth'] ?? "USD 0 / USD 0",
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      category: json['category'] != null
          ? ProductCategory.fromJson(json['category'])
          : null,
      unit: json['unit'] != null ? Unit.fromJson(json['unit']) : null,
      taxRate: json['tax'] != null ? Tax.fromJson(json['tax']) : null,
      costTax: json['cost_tax'] ??
          (json['tax'] != null
              ? (taxRate * cost * quantity).toStringAsFixed(2)
              : null),
      taxMethod: json['tax_method'],
      costSubtotal: json['tax_method'].toString().toLowerCase() == 'exclusive'
          ? (cost * quantity - discount).toStringAsFixed(2)
          : (cost * quantity + taxRate * cost * quantity - discount)
              .toStringAsFixed(2),
      discount: discount.toStringAsFixed(2),
      saleBatch: json['sale_batch'],
      saleQty: json['sale_qty'],
      saleReturnQty: json['sale_return_qty'],
      saleNetUnitPrice:
          double.tryParse(json['sale_net_unit_price'].toString()) ?? 0,
      saleTax: double.tryParse(json['sale_tax'].toString()) ?? 0,
      saleTaxRate: double.tryParse(json['sale_tax_rate'].toString()) ?? 0,
      saleDiscount: double.tryParse(json['sale_discount'].toString()) ?? 0,
      saleTotal: double.tryParse(json['sale_total'].toString()) ?? 0,
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => Product.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'barcode_symbology': barcodeSymbology,
      'name': name,
      'image': image,
      'code': code,
      'quantity': quantity,
      'cost': cost,
      'price': price,
      'discount': discount,
      'stock_worth': stockWorth,
      'brand': brand?.toMap(),
      'category': category?.toMap(),
      'unit': unit?.toMap(),
      'tax_method': taxMethod,
      'tax': taxRate?.toMap(),
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'type': type,
      'name': name,
      'code': code,
      'barcode_symbology': barcodeSymbology,
      'brand_id': brand?.id,
      'category_id': category?.id,
      'unit_id': unit?.id,
      'purchase_unit_id': purchaseUnit?.id,
      'sale_unit_id': saleUnit?.id,
      "cost": cost,
      "price": price,
      'discount': discount,
    };
  }
}
