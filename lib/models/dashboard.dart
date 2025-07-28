/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: dashboard
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/models/short_payment.dart';
import 'package:salepro/screens/products/models/short_product.dart';
import 'package:salepro/screens/purchases/models/short_purchase.dart';
import 'package:salepro/screens/quotations/models/short_quotations.dart';
import 'package:salepro/screens/sales/models/short_sale.dart';

class DashboardData implements Mappable {
  final String revenue;
  final String saleReturn;
  final String purchaseReturn;
  final String profit;
  final List<ShortSale> recentSales;
  final List<ShortPurchase> recentPurchases;
  final List<ShortQuotation> recentQuotations;
  final List<ShortPayment> recentPayments;
  final List<ShortProduct> bestSellerMonth;
  final List<ShortProduct> yearlyBestSellingByQty;
  final List<ShortProduct> yearlyBestSellingByPrice;

  DashboardData({
    required this.revenue,
    required this.saleReturn,
    required this.purchaseReturn,
    required this.profit,
    required this.recentSales,
    required this.recentPurchases,
    required this.recentQuotations,
    required this.recentPayments,
    required this.bestSellerMonth,
    required this.yearlyBestSellingByQty,
    required this.yearlyBestSellingByPrice,
  });

  factory DashboardData.fromJson(Map json) {
    return DashboardData(
      revenue: json['revenue'],
      saleReturn: json['sale_return'],
      purchaseReturn: json['purchase_return'],
      profit: json['profit'],
      recentSales: (json['recent_sales'] as List)
          .map((s) => ShortSale.fromJson(s))
          .toList(),
      recentPurchases: (json['recent_purchases'] as List)
          .map((p) => ShortPurchase.fromJson(p))
          .toList(),
      recentQuotations: (json['recent_quotations'] as List)
          .map((s) => ShortQuotation.fromJson(s))
          .toList(),
      recentPayments: (json['recent_payments'] as List)
          .map((s) => ShortPayment.fromJson(s))
          .toList(),
      bestSellerMonth: (json['best_seller_month'] as List)
          .map((p) => ShortProduct.fromJson(p))
          .toList(),
      yearlyBestSellingByQty: (json['yearly_best_selling_by_qty'] as List)
          .map((p) => ShortProduct.fromJson(p))
          .toList(),
      yearlyBestSellingByPrice: (json['yearly_best_selling_by_price'] as List)
          .map((p) => ShortProduct.fromJson(p))
          .toList(),
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => DashboardData.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'revenue': revenue,
      'sale_return': saleReturn,
      'purchase_return': purchaseReturn,
      'profit': profit,
      'recent_sales': recentSales.map((s) => s.toMap()).toList(),
      'recent_purchases': recentPurchases.map((p) => p.toMap()).toList(),
      'best_seller_month': bestSellerMonth.map((p) => p.toMap()).toList(),
      'yearly_best_selling_by_qty':
          yearlyBestSellingByQty.map((p) => p.toMap()).toList(),
      'yearly_best_selling_by_price':
          yearlyBestSellingByPrice.map((p) => p.toMap()).toList(),
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }
}
