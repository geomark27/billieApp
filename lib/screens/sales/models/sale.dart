/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: sale
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/models/user.dart';
import 'package:salepro/screens/people/biller/models/biller.dart';
import 'package:salepro/screens/people/customers/models/customer.dart';
import 'package:salepro/screens/products/models/product.dart';
import 'package:salepro/screens/settings/currencies/models/currency.dart';
import 'package:salepro/screens/settings/taxes/models/tax.dart';
import 'package:salepro/screens/settings/warehouse/models/warehouse.dart';

class Sale implements Mappable {
  final int id;
  final String date;
  final String referenceNo;
  final String? subTotal;
  final String grandTotal;
  final String returnAmount;
  final String paidAmount;
  final String dueAmount;
  final String saleStatus;
  final String paymentStatus;
  final String paymentMethod;
  final String deliveryStatus;
  final double exchangeRate;
  final Biller? biller;
  final Warehouse? warehouse;
  final Customer? customer;
  final Currency? currency;
  final Tax? orderTax;
  final String? orderDiscountType;
  final String? orderDiscount;
  final String? shippingCost;
  final String? saleNote;
  final String? staffNote;
  final User? createdBy;
  final List<Product>? products;

  Sale({
    required this.id,
    required this.date,
    required this.referenceNo,
    required this.saleStatus,
    required this.grandTotal,
    required this.returnAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.exchangeRate,
    required this.deliveryStatus,
    this.subTotal,
    this.warehouse,
    this.currency,
    this.products,
    this.orderTax,
    this.orderDiscount,
    this.shippingCost,
    this.biller,
    this.customer,
    this.createdBy,
    this.orderDiscountType,
    this.saleNote,
    this.staffNote,
  });

  factory Sale.fromJson(Map json) {
    return Sale(
      id: json['id'],
      date: json['date'] ?? "",
      referenceNo: json['reference_no'] ?? "",
      saleStatus: json['sale_status'].toString(),
      paymentStatus: json['payment_status'].toString(),
      paymentMethod: json['payment_method'].toString(),
      deliveryStatus: json['delivery_status'].toString(),
      grandTotal: (json['grand_total'] ?? 0).toString(),
      returnAmount: (json['returned_amount'] ?? 0).toString(),
      paidAmount: (json['paid_amount'] ?? 0).toString(),
      dueAmount: (json['due'] ?? 0).toString(),
      exchangeRate: double.tryParse(json['exchange_rate'].toString()) ?? 1.0,
      currency: json['currency'] != null
          ? Currency.fromJson(
              json['currency'],
            )
          : null,
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
      createdBy: json['created_by'] != null
          ? User.fromJson(
              json['created_by'],
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
  Mappable fromJson(Map<String, dynamic> json) => Sale.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'reference_no': referenceNo,
      'biller': biller?.toMap(),
      'customer': customer?.toMap(),
      'warehouse': warehouse?.toMap(),
      'sale_status': saleStatus,
      'payment_status': paymentStatus,
      'delivery_status': deliveryStatus,
      'grand_total': grandTotal,
      'returned_amount': returnAmount,
      'paid_amount': paidAmount,
      'due': dueAmount,
      'exchange_rate': exchangeRate,
      'currency': currency?.toMap(),
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    int totalQty = 0;
    double totalDiscount = 0.00;
    double totalTax = 0;
    double totalPrice = 0;

    if (products != null) {
      for (var p in products!) {
        totalQty += p.quantity;
        totalDiscount += 0;
        totalTax += double.parse(p.costTax ?? "0.0");
        totalPrice += double.parse(p.price);
      }
    }
    return {
      'created_at': date,
      'customer_id': customer?.id,
      'warehouse_id': warehouse?.id,
      'biller_id': biller?.id,
      'currency_id': currency?.id,
      'exchange_rate': exchangeRate,
      'qty': products?.map((p) => p.quantity.toString()).toList(),
      'product_batch_id': [null],
      'product_code': products?.map((p) => p.code).toList(),
      'product_id': products?.map((p) => p.id.toString()).toList(),
      'sale_unit': products?.map((p) => p.unit?.name).toList(),
      'net_unit_price': products?.map((p) => p.price).toList(),
      'discount': products?.map((p) => '0.00').toList(),
      'tax_rate':
          products?.map((p) => p.taxRate?.rate.toStringAsFixed(2)).toList(),
      'tax': products?.map((p) => p.costTax).toList(),
      'subtotal': products?.map((p) => p.costSubtotal).toList(),
      'imei_number': [null],
      'total_qty': totalQty.toString(),
      'total_discount': totalDiscount.toStringAsFixed(2),
      'total_tax': totalTax.toStringAsFixed(2),
      'total_price': totalPrice.toStringAsFixed(2),
      'item': products?.length,
      'order_tax': orderTax == null
          ? "0.00"
          : (orderTax!.rate * double.parse(subTotal ?? "0.00") / 100)
              .toStringAsFixed(2),
      'grand_total': grandTotal,
      'used_points': null,
      'pos': "0",
      'coupon_active': "0",
      'order_tax_rate': orderTax == null ? 0 : orderTax!.rate.toString(),
      'order_discount_type': orderDiscountType,
      'order_discount_value': null,
      'order_discount': orderDiscount,
      'shipping_cost': "0",
      'sale_status': saleStatus,
      'payment_status': paymentStatus,
      'paid_by_id': customer?.id,
      'paying_amount': paidAmount,
      'paid_amount': paidAmount,
      'payment_receiver': biller?.id,
      'reference_no': referenceNo,
      'gift_card_id': null,
      'cheque_no': null,
      'payment_note': null,
      'sale_note': saleNote,
      'staff_note': staffNote,
    };
  }
}
