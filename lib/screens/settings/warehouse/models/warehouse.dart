/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: warehouse
*/

import 'package:salepro/models/mappable.dart';

class Warehouse implements Mappable {
  final int id;
  final String name;
  final String? phone;
  final String email;
  final String address;
  final int numberOfProducts;
  final int stockQuantity;
  final bool? isCashRegistered;

  Warehouse({
    required this.id,
    required this.name,
    this.phone,
    required this.email,
    required this.address,
    required this.numberOfProducts,
    required this.stockQuantity,
    this.isCashRegistered,
  });

  factory Warehouse.fromJson(Map json) {
    return Warehouse(
      id: json["id"],
      name: json['name'],
      phone: json['phone'] ?? "No Phone Provided",
      email: json['email'] ?? "No Email Provided",
      address: json['address'],
      numberOfProducts: json['number_of_products'] ?? 0,
      stockQuantity: json['stock_quantity'] ?? 0,
      isCashRegistered: json['is_cash_registered'] ?? false,
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => Warehouse.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }
}
