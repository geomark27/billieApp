/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: purchase
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/people/suppliers/models/supplier.dart';
import 'package:salepro/screens/products/models/product.dart';
import 'package:salepro/screens/settings/currencies/models/currency.dart';
import 'package:salepro/screens/settings/taxes/models/tax.dart';
import 'package:salepro/screens/settings/warehouse/models/warehouse.dart';

class Purchase implements Mappable {
  final int id;
  final String date;
  final String referenceNo;
  final String purchaseStatus;
  final String? subTotal;
  final String grandTotal;
  final String returnAmount;
  final String paidAmount;
  final String dueAmount;
  final String paymentStatus;
  final double exchangeRate;
  final Supplier? supplier;
  final Warehouse? warehouse;
  final Currency? currency;
  final List<Product>? products;
  final Tax? orderTax;
  final String? orderDiscount;
  final String? shippingCost;
  final String? note;

  Purchase({
    required this.id,
    required this.date,
    required this.referenceNo,
    required this.purchaseStatus,
    this.subTotal,
    required this.grandTotal,
    required this.returnAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.paymentStatus,
    required this.exchangeRate,
    this.supplier,
    this.warehouse,
    this.currency,
    this.products,
    this.orderTax,
    this.orderDiscount,
    this.shippingCost,
    this.note,
  });

  factory Purchase.fromJson(Map json) {
    return Purchase(
      id: json['id'],
      date: json['date'] ?? "",
      referenceNo: json['reference_no'] ?? "",
      purchaseStatus: json['purchase_status'].toString(),
      grandTotal: (json['grand_total'] ?? 0).toString(),
      returnAmount: (json['return_amount'] ?? 0).toString(),
      paidAmount: (json['paid_amount'] ?? 0).toString(),
      dueAmount: (json['due_amount'] ?? 0).toString(),
      paymentStatus: json['payment_status'].toString(),
      exchangeRate: double.tryParse(json['exchange_rate'].toString()) ?? 1.0,
      supplier: json['supplier'] != null
          ? Supplier.fromJson(
              json['supplier'],
            )
          : null,
      warehouse: json['warehouse'] != null
          ? Warehouse.fromJson(
              json['warehouse'],
            )
          : null,
      currency: json['currency'] != null
          ? Currency.fromJson(
              json['currency'],
            )
          : null,
      products: json['products'] != null
          ? (json['products'] as List).map((p) => Product.fromJson(p)).toList()
          : [],
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => Purchase.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'reference_no': referenceNo,
      'purchase_status': purchaseStatus,
      'grand_total': grandTotal,
      'return_amount': returnAmount,
      'paid_amount': paidAmount,
      'due_amount': dueAmount,
      'payment_status': paymentStatus,
      'exchange_rate': exchangeRate,
      'supplier': supplier?.toMap(),
      'warehouse': warehouse?.toMap(),
      'currency': currency?.toMap(),
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    int totalQty = 0;
    double totalDiscount = 0.00;
    double totalTax = 0;
    double totalCost = 0;

    if (products != null) {
      for (var p in products!) {
        totalQty += p.quantity;
        totalDiscount += 0;
        totalTax += double.parse(p.costTax ?? "0.0");
        totalCost += double.parse(p.cost);
      }
    }
    return {
      'created_at': date,
      'reference_no': referenceNo,
      'warehouse_id': warehouse?.id,
      'supplier_id': supplier?.id,
      'status': purchaseStatus,
      'recieved': ['1'],
      'batch_no': [null],
      'expired_date': [null],
      'imei_number': [null],
      'currency_id': currency?.id,
      'exchange_rate': exchangeRate,
      'product_code': products?.map((p) => p.code).toList(),
      'product_id': products?.map((p) => p.id.toString()).toList(),
      'qty': products?.map((p) => p.quantity.toString()).toList(),
      'purchase_unit': products?.map((p) => p.unit?.name).toList(),
      'net_unit_cost': products?.map((p) => p.cost).toList(),
      'discount': products?.map((p) => '0.00').toList(),
      'tax_rate':
          products?.map((p) => p.taxRate?.rate.toStringAsFixed(2)).toList(),
      'tax': products?.map((p) => p.costTax).toList(),
      'subtotal': products?.map((p) => p.costSubtotal).toList(),
      'total_qty': totalQty.toString(),
      'total_discount': totalDiscount.toStringAsFixed(2),
      'total_tax': totalTax.toStringAsFixed(2),
      'total_cost': totalCost.toStringAsFixed(2),
      'item': products?.length,
      'order_tax': orderTax == null
          ? "0.00"
          : (orderTax!.rate * double.parse(subTotal ?? "0.00") / 100)
              .toStringAsFixed(2),
      'grand_total': grandTotal,
      'paid_amount': paidAmount,
      'payment_status': paymentStatus,
      'order_tax_rate': orderTax == null ? 0 : orderTax!.rate.toString(),
      'order_discount': orderDiscount,
      'shipping_cost': shippingCost,
      'note': note
    };
  }
}
