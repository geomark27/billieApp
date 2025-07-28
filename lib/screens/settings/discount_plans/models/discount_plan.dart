/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: discount_plan
*/

import 'package:salepro/models/mappable.dart';
import 'package:salepro/screens/people/customers/models/customer.dart';

class DiscountPlan implements Mappable {
  final int id;
  final String name;
  final List<Customer> customers;
  final String isActive;

  DiscountPlan({
    required this.id,
    required this.name,
    required this.customers,
    required this.isActive,
  });

  factory DiscountPlan.fromJson(Map json) {
    return DiscountPlan(
      id: json['id'],
      name: json['name'] ?? "No Name",
      customers: json['customers'] != null
          ? (json['customers'] as List)
              .map((c) => Customer.fromJson(c))
              .toList()
          : [],
      isActive: json['is_active'].toString(),
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => DiscountPlan.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'customers': customers.map((c) => c.toMap()).toList(),
      'is_active': isActive,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'name': name,
      'customer_id': customers.map((c) => c.id.toString()).toList(),
      'is_active': isActive,
    };
  }
}
