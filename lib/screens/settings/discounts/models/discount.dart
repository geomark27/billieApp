/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: discount
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/products/models/product.dart';
import 'package:salepro/screens/settings/discount_plans/models/discount_plan.dart';

class Discount implements Mappable {
  final int id;
  final String name;
  final String applicableFor;
  final String validFrom;
  final String validTill;
  final String discountType;
  final double value;
  final int minQty;
  final int maxQty;
  final String days;
  final List<DiscountPlan> discountPlans;
  final List<Product> products;
  final String isActive;

  Discount({
    required this.id,
    required this.name,
    required this.discountPlans,
    required this.products,
    required this.applicableFor,
    required this.validFrom,
    required this.validTill,
    required this.discountType,
    required this.value,
    required this.minQty,
    required this.maxQty,
    required this.days,
    required this.isActive,
  });

  factory Discount.fromJson(Map json) {
    return Discount(
      id: json['id'],
      name: json['name'] ?? "No Name",
      discountPlans: json['discount_plans'] != null
          ? (json['discount_plans'] as List)
              .map((c) => DiscountPlan.fromJson(c))
              .toList()
          : [],
      products: json['applicable_for'].toString() == "all"
          ? []
          : json['products'] != null
              ? (json['products'] as List)
                  .map((p) => Product.fromJson(p))
                  .toList()
              : [],
      applicableFor: json['applicable_for'],
      validFrom: json['valid_from'],
      validTill: json['valid_till'],
      discountType: json['discount_type'],
      value: json['value'],
      minQty: json['minimum_qty'],
      maxQty: json['maximum_qty'],
      days: json['days'],
      isActive: json['is_active'].toString(),
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => Discount.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'discount_plans': discountPlans.map((c) => c.toMap()).toList(),
      'products': products.map((p) => p.toMap()).toList(),
      'applicable_for': applicableFor,
      'valid_from': validFrom,
      'valid_till': validTill,
      'discount_type': discountType,
      'value': value,
      'minimum_qty': minQty,
      'maximum_qty': maxQty,
      'days': days,
      'is_active': isActive,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'name': name,
      'discount_plan_id': discountPlans.map((c) => c.id.toString()).toList(),
      'product_code': products.map((p) => p.code.toString()).toList(),
      'applicable_for': applicableFor,
      'valid_from': validFrom,
      'valid_till': validTill,
      'type': discountType,
      'value': value,
      'minimum_qty': minQty,
      'maximum_qty': maxQty,
      'days': days.split(', '),
      'is_active': isActive,
    };
  }
}
